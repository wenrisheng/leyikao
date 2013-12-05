//
//  ProvinceYikaoInfoViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoDao.h"
@interface ProvinceYikaoInfoViewController : UIViewController<InfoDaoDelegate,UITableViewDataSource,UITableViewDelegate>
{
    InfoDao *infoDao;
    NSArray *dataArray;
}
@property(retain,nonatomic)NSString *provinceId;
@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)backAction:(id)sender;
@end
