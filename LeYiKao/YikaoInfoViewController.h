//
//  YikaoInfoViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YikaoInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    NSMutableArray *sectionArray;
    NSMutableArray *originArray;
    
    NSMutableDictionary *idOrderDid;
    
}

- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)searchButtonAction:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *table;

@end
