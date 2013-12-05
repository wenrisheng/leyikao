//
//  DetailActivityViewController.h
//  LeYiKao
//
//  Created by athudong on 13-11-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
@interface DetailActivityViewController : UIViewController<CommunityDaoDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CommunityDao *communityDao;
    NSArray *dataArray;
}
- (IBAction)backAction:(id)sender;
- (IBAction)liuyanAction:(id)sender;
- (IBAction)enterAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *jiaruLabel;
@property (retain, nonatomic) IBOutlet UILabel *dianjiLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (retain, nonatomic) IBOutlet UILabel *huifuLabel;

@property (retain, nonatomic) IBOutlet UITableView *table;
@property(retain,nonatomic)NSString *activityId;
@property (retain, nonatomic) IBOutlet UIView *liuyanView;
@property (retain, nonatomic) IBOutlet UITextView *textView;
- (IBAction)liuyanButtonAction:(id)sender;


@end
