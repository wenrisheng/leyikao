//
//  InfoDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InfoDaoDelegate <NSObject>
@optional
-(void)findInfoByProvinceIdSuc:(id)value;
-(void)findInfoByProvinceIdFail:(NSError *)error;

-(void)findInfoByYikaoIdSuc:(id)value;
-(void)findInfoByYikaoIdFail:(NSError *)error;
@end

@interface InfoDao : NSObject
@property(nonatomic,assign)id<InfoDaoDelegate> delegate;
-(void)findInfoByProvinceId:(NSString *)provinceId;
-(void)findInfoByYikaoId:(NSString *)yikaoId;
@end
