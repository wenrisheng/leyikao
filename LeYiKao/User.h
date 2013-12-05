//
//  User.h
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

enum UserActionType{
    kLogin,
    kRegister
};
typedef enum UserActionType UserActionType;
@interface User : NSObject
@property(nonatomic,retain)NSString *tel;
@property(retain,nonatomic)NSString *password;
@property(retain,nonatomic)NSString *grade;
@property(retain,nonatomic)NSString *profession;
@end
