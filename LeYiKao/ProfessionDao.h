//
//  ProfessionDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfessionDaoDelegate <NSObject>

-(void)getProfessionByTypeSuc:(id)value;
-(void)getProfessionByTypeFail:(NSError *)error;

-(void)getDetailProfessionByProIdSuc:(id)value;
-(void)getDetailProfessionByProIdFail:(NSError *)error;
@end

@interface ProfessionDao : NSObject
@property(assign,nonatomic)id<ProfessionDaoDelegate> delegate;
-(void)getProfessionByType:(NSString *)typeID;
-(void)getDetailProfessionByProId:(NSString *)proId;
@end
