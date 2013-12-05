//
//  CollectDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-25.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectDaoDelegate <NSObject>

-(void)collectByUMISuc:(id)value;
-(void)collectByUMIFail:(NSError *)error;

-(void)findCollectsByUPPSuc:(id)value;
-(void)findCollectsByUPPFail:(NSError *)error;

-(void)deleteCollectByUCSuc:(id)value;
-(void)deleteCollectByUCFail:(NSError *)error;
@end

@interface CollectDao : NSObject
@property(assign,nonatomic)id<CollectDaoDelegate> delegate;
-(void)collectByUserId:(NSString *)userId module:(NSString *)module id:(NSString *)ID;
-(void)findCollectsByUserId:(NSString *)userId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize;

-(void)deleteCollectbyUserId:(NSString *)userId collectId:(NSString *)collectId;
@end
