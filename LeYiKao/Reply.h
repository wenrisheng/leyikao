//
//  Reply.h
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reply : NSObject
@property(retain,nonatomic)NSString *ID;
@property(retain,nonatomic)NSString *postId;
@property(retain,nonatomic)NSString *userId;
@property(retain,nonatomic)NSString *createTime;
@property(retain,nonatomic)NSString *content;

@end
