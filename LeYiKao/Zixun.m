//
//  Zixun.m
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "Zixun.h"

@implementation Zixun
-(void)dealloc{
    self.ID=nil;
    self.userId=nil;
    self.hits=nil;
    self.replies=nil;
    self.title=nil;
    self.createTime=nil;
    [super dealloc];
}
@end
