//
//  User.m
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "User.h"

@implementation User
-(void)dealloc{
    [_tel release];
    _tel=nil;
    [_password release];
    _password=nil;
    [_grade release];
    _grade=nil;
    [_profession release];
    _profession=nil;
    [super dealloc];
}
@end
