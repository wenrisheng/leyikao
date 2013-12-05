//
//  DetailYikaoInfoViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoDao.h"
#import "CollectDao.h"
@interface DetailYikaoInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,InfoDaoDelegate,CollectDaoDelegate>
{
    InfoDao *infoDao;
    
    NSDictionary *dic;
    CollectDao *collectDao;
}
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *schoolLabel;
@property(nonatomic,retain)NSString *schoolId;
- (IBAction)colectAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *propertyLabel;
@property (retain, nonatomic) IBOutlet UILabel *regionLabel;
@property (retain, nonatomic) IBOutlet UILabel *levelLabel;
@property (retain, nonatomic) IBOutlet UILabel *telLabel;
- (IBAction)introlAction:(id)sender;
- (IBAction)anpaiAction:(id)sender;

- (IBAction)contentAction:(id)sender;
- (IBAction)wenhuaGradeAction:(id)sender;

- (IBAction)profGradeAction:(id)sender;

@end
