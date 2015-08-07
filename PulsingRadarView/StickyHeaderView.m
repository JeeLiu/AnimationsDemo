//
//  StickyHeaderView.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/7.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "StickyHeaderView.h"

static NSString * const KEY_PATH_CONTENTOFFSET = @"contentOffset";

@interface StickyHeaderView ()
@property (nonatomic, assign) CGFloat minHeight;
@end

@implementation StickyHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(0, 0, 0, height)];
    if (self) {
        self.minHeight = height;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:KEY_PATH_CONTENTOFFSET];
    
    if (newSuperview) {
        NSAssert([newSuperview isKindOfClass:[UIScrollView class]],@"superview must be UIScrollView!");
        
        CGRect newFrame = self.frame;
        newFrame.size.width = newSuperview.bounds.size.width;
        self.frame = newFrame;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [newSuperview addObserver:self forKeyPath:KEY_PATH_CONTENTOFFSET options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (keyPath == KEY_PATH_CONTENTOFFSET) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        
        CGFloat delta = 0.f;
        NSLog(@"scrollView.contentOffset.y == %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y < 0.0) {
            delta = fabs(MIN(0.0, scrollView.contentOffset.y));
        }
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = -delta;
        newFrame.size.height = self.minHeight + delta;
        
        self.frame = newFrame;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
