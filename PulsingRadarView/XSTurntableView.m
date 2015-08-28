//
//  XSTurntableView.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/28.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "XSTurntableView.h"
#import "XSPlayAudio.h"

#import <QuartzCore/QuartzCore.h>

static int const kTurntableNumber = 12;

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@implementation XSTurntableView {
    NSInteger currentTag;
    BOOL _isAnimationing;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    CGFloat viewW = self.bounds.size.width;
    CGFloat angle = DEGREES_TO_RADIANS(360.f / kTurntableNumber);
    
    for (int i = 0; i < kTurntableNumber; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bt_%d.png",i + 1]];
        [button setFrame:CGRectMake((viewW - image.size.width)/2.0,0.0 + image.size.height/2.0 ,image.size.width, image.size.height)];
        button.layer.anchorPoint = CGPointMake(0.5f,1.0f);
        button.layer.transform= CATransform3DMakeRotation(angle * i *1.0,0.0, 0.0, 1.0);
        
        [button setImage:image forState:UIControlStateNormal];
        image = [UIImage imageNamed:[NSString stringWithFormat:@"bt_selected_%d.png",i + 1]];
        [button setImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)touched:(UIButton *)button {
    if (button.tag ==  currentTag) {
        return;
    }
    
    if (!_isAnimationing) {
        _isAnimationing = YES;
        currentTag = button.tag;
        [XSPlayAudio playAudio:@"Tink.wav"];
        
        [UIView animateWithDuration:1 animations:^{
            
            self.layer.transform = CATransform3DMakeRotation([self getAngle:currentTag endTag:button.tag],0.0, 0.0, 1.0);
            
        } completion:^(BOOL finished) {
            _isAnimationing = NO;
        }];
    }
}

- (CGFloat)getAngle:(NSInteger)current endTag:(NSInteger)end {
    int tmp = kTurntableNumber/2;
    if (end > tmp) {
        return  DEGREES_TO_RADIANS((kTurntableNumber - end) * (360.0/kTurntableNumber));
    } else {
        return DEGREES_TO_RADIANS(-end * (360.0/kTurntableNumber));
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextScaleCTM(context,1.0,-1.0);
    CGContextTranslateCTM(context, 0,-self.bounds.size.height);
    UIImage *img = [UIImage imageNamed:@"bg_circle.png"];
    CGContextDrawImage(context,self.bounds,img.CGImage);
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    img = [UIImage imageNamed:@"bg_point.png"];
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    CGRect Rect =  CGRectMake((viewW - w)/2.0,(viewH -h)/2.0 + 60,w,h);
    CGContextDrawImage(context,Rect,img.CGImage);
    
    
    img = [UIImage imageNamed:@"bg_center.png"];
    w = img.size.width;
    h = img.size.height;
    Rect =  CGRectMake((viewW - w)/2.0,(viewH -h)/2.0,w,h);
    CGContextDrawImage(context,Rect,img.CGImage);
    
    CGContextRestoreGState(context);
    
}



@end
