//
//  DetailProfessionViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfessionDao.h"
#import "CollectDao.h"
@interface DetailProfessionViewController : UIViewController<ProfessionDaoDelegate,CollectDaoDelegate>
{
    ProfessionDao *professionDao;
    CollectDao *collectDao;
}
- (IBAction)backAction:(id)sender;
@property(retain,nonatomic)NSString *proId;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UITextView *jianjieTextView;
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;

- (IBAction)collectAction:(id)sender;

@end
