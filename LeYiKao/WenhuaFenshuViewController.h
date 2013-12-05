//
//  WenhuaFenshuViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-24.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WenhuaFenshuViewController : UIViewController
@property(retain,nonatomic)NSString *str;
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITextView *textView;

@end
