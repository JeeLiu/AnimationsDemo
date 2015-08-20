//
//  ScaleFlowLayout.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/20.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "ScaleFlowLayout.h"

static CGFloat const kFlowLayoutItemSize = 65;
static CGFloat const kFlowLayoutActiveDistance = 65;
static CGFloat const kFlowLayoutZoomScale = 0.8;

@implementation ScaleFlowLayout

+ (instancetype)flowLayout {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (self = [super init]) {
        
        self.itemSize = CGSizeMake(kFlowLayoutItemSize, kFlowLayoutItemSize);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
        self.minimumLineSpacing = 50.f;
        
    }
    
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGFloat)zoomScale {
    return 1 + kFlowLayoutZoomScale;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / kFlowLayoutActiveDistance;
            
            if (ABS(distance) < kFlowLayoutActiveDistance) {
                
                CATransform3D transform = attributes.transform3D;
                transform = CATransform3DMakeTranslation(0, (1 - ABS(normalizedDistance))*-20, 0);
                
                CGFloat zoom = 1 + kFlowLayoutZoomScale * (1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DScale(transform, zoom, zoom, 1);
                
                attributes.zIndex = round(zoom);
                
            }
        }
    }
    return layoutAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        CGFloat itemHorizontalCenter = attributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    
}

@end
