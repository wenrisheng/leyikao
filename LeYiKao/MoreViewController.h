//
//  MoreViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UIAlertViewDelegate>
- (IBAction)myCellectionAction:(id)sender;
- (IBAction)shareWithFriendAction:(id)sender;
- (IBAction)exanintUpdateAction:(id)sender;
- (IBAction)aboutUsAction:(id)sender;
- (IBAction)logoutAction:(id)sender;

- (IBAction)backAction:(id)sender;

@end
