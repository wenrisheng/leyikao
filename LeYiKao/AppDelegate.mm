//
//  AppDelegate.m
//  LeYiKao
//
//  Created by athudong on 13-10-12.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "RichenganpaiViewController.h"
#import "YikaoCommunityViewController.h"
#import "YikaoInfoViewController.h"
#import "PeixunbanViewController.h"
#import "WritePostViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //推送通知
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
   // application.applicationIconBadgeNumber=1;
    
    BMKMapManager* _mapManager;
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"0C274ff43f10efbaa5e3b77c19e1f0ca" generalDelegate:self];
    //    注意：为了给用户提供更安全的服务，iOS SDK自V2.0.2版本开始采用全新的key验证体系。
    //    因此当你选择使用，V2.0.2及以后版本的SDK时，需要到新的key申请页面进行全新key的申请，申请及配置流程请参考开发指南的对应章节。
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    [_mapManager release];

    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainViewController *mainVC=[[MainViewController alloc] init];
    
    HomeViewController *homeVC=[[HomeViewController alloc] init];
    RichenganpaiViewController *rcVC=[[RichenganpaiViewController alloc]init];
    
    YikaoCommunityViewController *ycVC=[[YikaoCommunityViewController alloc]init];
    YikaoInfoViewController *inVC=[[YikaoInfoViewController alloc]init];
    PeixunbanViewController *pxVC=[[PeixunbanViewController alloc]init];
    WritePostViewController *writePostVC=[[WritePostViewController alloc]init];
    UINavigationController *root=[[UINavigationController alloc] initWithRootViewController:mainVC];
    writePostVC=nil;
    homeVC=Nil;
    mainVC=nil;
    rcVC=nil;
    ycVC=nil;
    inVC=nil;
    pxVC=nil;
    self.window.rootViewController=root;
    root=nil;
    
    
         return YES;
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"设备令牌：%@",deviceToken);
    NSString *token=[NSString stringWithFormat:@"%@",deviceToken];
    
    if([token length]==0) {
        return;
    }
    NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"\<\>"];
    token=[token stringByTrimmingCharactersInSet:set];
    token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"register:%@",error);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"收到远程通知：%@",userInfo);
}
- (void)onGetNetworkState:(int)iError
{
    
    NSLog(@"onGetNetworkState %d",iError);
    
    
}

- (void)onGetPermissionState:(int)iError
{
    
    NSLog(@"onGetPermissionState %d",iError);
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
#pragma mark - qq
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
