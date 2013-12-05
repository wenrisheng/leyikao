//
//  UIAlertView+ShowShortMessage.h
//  录制视频音频
//
//  Created by athudong on 13-11-8.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (ShowShortMessage)
+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message timeInterval:(NSTimeInterval)timInterval;
@end
