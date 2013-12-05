//
//  YikaoCommunityViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
#import "MBProgressHUD.h"
@interface YikaoCommunityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CommunityDaoDelegate>
{
    BOOL isRenqi;
    CommunityDao *communityDao;
       MBProgressHUD *aiView;
    NSArray *activityArray;

}
@property (retain, nonatomic) IBOutlet UITableView *activityTable;
@property(retain,nonatomic)NSArray *dataArray;
- (IBAction)backAction:(id)sender;
- (IBAction)writeAction:(id)sender;

- (IBAction)refreshAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)renqiAction:(id)sender;
- (IBAction)zuixinAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *topImage;
@property (retain, nonatomic) IBOutlet UIView *activityView;

@end
