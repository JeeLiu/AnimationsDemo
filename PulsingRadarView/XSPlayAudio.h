//
//  XSPlayAudio.h
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/28.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface XSPlayAudio : NSObject
+ (void)playSystemAudio:(SystemSoundID)id;//播放系统声音 id:系统声音的id
+ (void)playAudio:(NSString *)audioName;
@end
