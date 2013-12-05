//
//  CollectionViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectDao.h"


@interface CollectionViewController : UIViewController<CollectDaoDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CollectDao *collectDao;
    NSArray *dataArray;
    BOOL isEdited;
}
- (IBAction)backAction:(id)sender;
- (IBAction)deleteActioin:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *table;
@end
