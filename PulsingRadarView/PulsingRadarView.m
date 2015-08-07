//
//  PulsingRadarView.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/7.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "PulsingRadarView.h"
#import <QuartzCore/QuartzCore.h>
@implementation PulsingRadarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [[UIColor whiteColor] setFill];
    
    UIRectFill(rect);
    
    int pulsingCount = 6;
    CGFloat animationDuration = 4;
    
    CALayer *animationLayer = [CALayer new];
    
    for (int i =0; i < pulsingCount; i++) {
        CALayer *pulsingLayer = [CALayer new];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = [UIColor grayColor].CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2 ;
        
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup new];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE_VAL;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.autoreverses = NO;
        scaleAnimation.fromValue = @0;
        scaleAnimation.toValue = @1.5;
        
        
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1,@0.7,@0];
        opacityAnimation.keyTimes = @[@0,@0.5,@1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"pulsingAnimation"];
        [animationLayer addSublayer:pulsingLayer];
        
    }
    
    [self.layer addSublayer:animationLayer];
    
}

@end
