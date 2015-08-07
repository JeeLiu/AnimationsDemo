//
//  FlowLayout.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/7.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1./800.;
    transform = CATransform3DRotate(transform, M_PI_2, -1, 0, 0);
    transform = CATransform3DScale(transform, .8, .8, .8);
    attributes.transform3D = transform;
    
    return attributes;
}
@end
