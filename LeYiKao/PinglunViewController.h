//
//  PinglunViewController.h
//  LeYiKao
//
//  Created by athudong on 13-11-11.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeixunbanDao.h"
@interface PinglunViewController : UIViewController<PeixunbanDaoDelegate>
{
    PeixunbanDao *peixunbaiDao;
}
@property(retain,nonatomic)NSString *trainingId;
@property (retain, nonatomic) IBOutlet UITextView *textView;

- (IBAction)fabiaoAction:(id)sender;

@end
