//
//  DetailPeixunbanViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-22.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeixunbanDao.h"
#import "CollectDao.h"
@interface DetailPeixunbanViewController : UIViewController<PeixunbanDaoDelegate,CollectDaoDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PeixunbanDao *peixunbanDao;
    NSDictionary *dic;
    CollectDao *collectDao;
    NSArray *dataArray;
}
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView1;
@property (retain, nonatomic) IBOutlet UIImageView *imageView2;


- (IBAction)telAction:(id)sender;
- (IBAction)pinglunAction:(id)sender;
- (IBAction)collectAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *table;

@property(retain,nonatomic)NSString *peixunbanId;
@end
