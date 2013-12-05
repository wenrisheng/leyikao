//
//  DetailCommunityViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
#import "CollectDao.h"
@interface DetailCommunityViewController : UIViewController<CommunityDaoDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CommunityDao *communityDao;
    NSArray *dataArray;
    CollectDao *collectDao;
}
@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollVew;
@property (retain, nonatomic) IBOutlet UIScrollView *imageScrollView;
- (IBAction)collectAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *userLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dianjiLabel;
@property (retain, nonatomic) IBOutlet UITextView *contenTextView;
- (IBAction)backAction:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *replyLabel;
@property (retain, nonatomic) IBOutlet UILabel *createlabel;

@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)WritePinglunAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property(retain,nonatomic)NSString *postId;
@end
