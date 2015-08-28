//
//  XSPlayAudio.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/28.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "XSPlayAudio.h"

@implementation XSPlayAudio
+ (void)playSystemAudio:(SystemSoundID)id {
    AudioServicesPlaySystemSound(id);
}

+ (void)playAudio:(NSString *)audioName {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],audioName];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
