//
//  DetailZixunViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-24.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
#import "CollectDao.h"
@interface DetailZixunViewController : UIViewController<CommunityDaoDelegate,CollectDaoDelegate>
{
    CommunityDao *communityDao;
    CollectDao *collectDao;
    NSDictionary *dic;
}
@property(retain,nonatomic)NSString *zixunId;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UITextView *introlLabel;
@property (retain, nonatomic) IBOutlet UITextView *contentLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)backAction:(id)sender;
- (IBAction)collectAction:(id)sender;

@end
