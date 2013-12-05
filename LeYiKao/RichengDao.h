//
//  RichengDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-17.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Richeng.h"
#import "FMDatabase.h"
@protocol RichengDaoDelegate <NSObject>
@optional
-(void)saveSuc;
-(void)saveFail:(NSError *)error;

-(void)findRichengByYMDSuc:(NSMutableArray *)array;
-(void)findRichengByYMDFail:(NSError *)error;

-(void)saveRichengByUYMDCSuc:(id)value;
-(void)saveRichengByUYMDCFail:(NSError *)error;

-(void)updateRichengByUYMDCSuc:(id)value;
-(void)updateRichengByUYMDCFail:(NSError *)error;

-(void)deleteRichengByUYMDCSuc:(id)value;
-(void)deleteRichengByUYMDCFail:(NSError *)error;

-(void)findRichengByUYMSuc:(id)value;
-(void)findRichengByUYMFail:(NSError *)error;
@end

@interface RichengDao : NSObject
@property(nonatomic,retain)FMDatabase *db;
@property(assign,nonatomic)id<RichengDaoDelegate> delegate;
-(void)save:(Richeng *)richeng;
-(void)update:(Richeng *)richeng;
-(void)findRichengByYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
-(NSMutableArray *)findRichengDaysByYear:(NSString *)year month:(NSString *)month;

///////////保存到服务器
-(void)saveRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day content:(NSString *)content;
-(void)updateRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day content:(NSString *)content;
-(void)deleteRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day;
-(void)findRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month;

@end
