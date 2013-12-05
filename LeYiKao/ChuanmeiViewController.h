//
//  ChuanmeiViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfessionDao.h"

enum vcType {
  chuanmei,
    music,
    meishu
    };
typedef enum vcType vcType;
@interface ChuanmeiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ProfessionDaoDelegate>
{
    NSArray *dataArray;
    ProfessionDao *professionDao;
}
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property(assign,nonatomic)vcType vcType;
@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)backAction:(id)sender;

@end
