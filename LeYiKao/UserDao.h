//
//  UserDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "User.h"
@protocol UserDaoDelegate <NSObject>
@optional
-(void)loginSuc:(id)value;
-(void)LoginFail:(NSError *)error;
-(void)registerSuc:(id)value;
-(void)registerFail:(NSError *)error;
@end

@interface UserDao : NSObject<ASIHTTPRequestDelegate>
@property(retain,nonatomic)id<UserDaoDelegate> delegate;
-(void)loginByTelephone:(NSString *)tel password:(NSString *)password;
-(void)registerUser:(User *)user;
@end
