//
//  HomeViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
@interface HomeViewController : UIViewController<CommunityDaoDelegate>
{
    BOOL isLeft;
    int currentPage;
    int totalPage;
    CommunityDao *communityDao;
    NSArray *zuixinZixunArray;
}
- (IBAction)topButtonAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *bigScrollView;

@property (retain, nonatomic) IBOutlet UIScrollView *smallScrollView;
- (IBAction)professionIntroduceAction:(id)sender;
- (IBAction)peixunbanAction:(id)sender;
- (IBAction)yikaoInfoAction:(id)sender;
- (IBAction)yikaoCommunityAction:(id)sender;
- (IBAction)richengaipaiAction:(id)sender;
- (IBAction)moreAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *oneModelView;
@property (retain, nonatomic) IBOutlet UIView *twoModelView;
@property (retain, nonatomic) IBOutlet UIView *threeModelView;


@end
