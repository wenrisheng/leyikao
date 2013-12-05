//
//  CommunityDao.h
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommunityDaoDelegate <NSObject>
@optional
-(void)findZixunBypageNOSizeSortSuc:(id)value;
-(void)findZixunBypageNOSizeSortFail:(NSError *)error;

-(void)findZuixinZixunSuc:(id)value;
-(void)findZuixinZixunFail:(NSError *)error;

-(void)findDetailZixuByIdSuc:(id)value;
-(void)findDetailZixuByIdFail:(NSError *)error;

-(void)createPostSuc:(id)value;
-(void)createPostFail:(NSError *)error;

-(void)findDetailZuixinZixunByZixunIdSuc:(id)value;
-(void)findDetailZuixinZixunByZixunIdFail:(NSError *)error;

-(void)createFaTieWithUPCSuc:(id)value;
-(void)createFaTieWithUPCFail:(NSError *)error;

-(void)findActivitiesByPageNoSuc:(id)value;
-(void)findActivitiesByPageNoFail:(NSError *)error;

-(void)findDetailActivityByActivityIdSuc:(id)value;
-(void)findDetailActivityByActivityIdFail:(NSError *)error;

-(void)baomingActivityWithUSSuc:(id)value;
-(void)baomingActivityWithUSFail:(NSError *)error;

-(void)liuyanWithUCSuc:(id)value;
-(void)liuyanWithUCFail:(NSError *)error;
@end

@interface CommunityDao : NSObject
@property(assign,nonatomic)id<CommunityDaoDelegate> delegate;
-(void)findZixunBypageNo:(NSString *)pageNo pageSize:(NSString *)pageSize sort:(NSString *)sort;

-(void)findZuixinZixun;
-(void)findDetailZuixinZixunByZixunId:(NSString *)zixunId;

-(void)findDetailZixuById:(NSString *)ID;
-(void)createPostWithUserId:(NSString *)userId title:(NSString *)title content:(NSString *)content image:(NSMutableArray *)imageData;
-(void)createPinglunWithUserId:(NSString *)userId postId:(NSString *)postId content:(NSString *)content image:(NSData *)imageData;

-(void)findActivitiesByPageNo:(NSString *)pageNo;
-(void)findDetailActivityByActivityId:(NSString *)activityId;

-(void)baomingActivityWithUserId:(NSString *)userId activityId:(NSString *)activityId;
-(void)liuyanWithUserId:(NSString *)userId activityId:(NSString *)activityId content:(NSString *)content;
@end
