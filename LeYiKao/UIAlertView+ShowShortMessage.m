//
//  UIAlertView+ShowShortMessage.m
//  录制视频音频
//
//  Created by athudong on 13-11-8.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "UIAlertView+ShowShortMessage.h"

@implementation UIAlertView (ShowShortMessage)
+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message timeInterval:(NSTimeInterval)timInterval{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    [NSTimer scheduledTimerWithTimeInterval:timInterval target:self selector:@selector(dismissAlertView:) userInfo:alertView repeats:NO];
    [alertView release];

}
+(void)dismissAlertView:(NSTimer *)timer{
    UIAlertView *alertView=[timer userInfo];
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
@end
