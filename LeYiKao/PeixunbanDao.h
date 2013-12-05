//
//  PeixunbanDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-19.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeixunbanDaoDelegate <NSObject>

-(void)findProvincesSuc:(id)value;
-(void)findProvincesFail:(NSError *)error;

-(void)findCitySuc:(id)value;
-(void)findCityFail:(NSError *)error;

-(void)findSpecialtySuc:(id)value;
-(void)findSpecialtyFail:(NSError *)error;

-(void)searchPeisunbanByPCSSuc:(id)value;
-(void)searchPeisunbanByPCSFail:(id)value;

-(void)findPeixunbanByIdSuc:(id)value;
-(void)findPeixunbanByIdFail:(NSError *)error;

-(void)findPeixunbanPinglunByIdSuc:(id)value;
-(void)findPeixunbanPinglunByIdFail:(NSError *)error;

-(void)fabiaoPeixunbanPinglunByUCSuc:(id)value;
-(void)fabiaoPeixunbanPinglunByUCFail:(NSError *)error;
@end

@interface PeixunbanDao : NSObject
@property(assign,nonatomic)id<PeixunbanDaoDelegate> delegate;
-(void)findProvinces;

-(void)findCities;
-(void)findSpecialties;
-(void)searchPeixunbanByProvince:(NSString *)province city:(NSString *)city specialty:(NSString *)spectalty keyword:(NSString *)keyword;
-(void)findPeixunbanById:(NSString *)peisunbanId;

-(void)findPeixunbanPinglunById:(NSString *)peixunbanid;
-(void)fabiaoPeixunbanPinglunByUserId:(NSString *)userId trainingId:(NSString *)trainingId Content:(NSString *)peixunbanid;
@end
