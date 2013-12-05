//
//  WenhuaFenshuViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-24.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "WenhuaFenshuViewController.h"

@interface WenhuaFenshuViewController ()

@end

@implementation WenhuaFenshuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textView.text=_str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    _str=nil;
    [_textView release];
    [super dealloc];
}
@end
