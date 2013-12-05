//
//  ProfessionIntroduceViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ProfessionIntroduceViewController.h"
#import "ChuanmeiViewController.h"
#import "MusicViewController.h"
#import "MeishuViewController.h"
@interface ProfessionIntroduceViewController ()

@end

@implementation ProfessionIntroduceViewController

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
//    self.navigationController.navigationBarHidden=NO;
//    self.navigationController.navigationBar.frame=CGRectMake(0, 20, UIScreenWidth, 35);
//    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    UIImage *leftImage=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
//     UIImage *leftImage1=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back1" ofType:@"png"]];
//    [leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
//    [leftButton setBackgroundImage:leftImage1 forState:UIControlStateSelected];
//    UIBarButtonItem *leftBarButtonIetm=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem=leftBarButtonIetm;
//    
//    leftImage=nil;
//    leftImage1=nil;
//    leftButton=nil;
//    leftBarButtonIetm=nil;
//    
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    label.text=@"专业介绍";
//    [label setFont:[UIFont fontWithName:@"Arial" size:13]];
//    label.textColor=[UIColor colorWithRed:0.94 green:0.29 blue:0.15 alpha:1];
//    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:label];
//    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
//    label=nil;
//    rightBarButtonItem=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chuanmeiAction:(id)sender {
    ChuanmeiViewController *chuanmeiVC=[[ChuanmeiViewController alloc]init];
    chuanmeiVC.vcType=chuanmei;
    [self.navigationController pushViewController:chuanmeiVC animated:YES];
    chuanmeiVC=nil;
    
}

- (IBAction)musicAction:(id)sender {
    ChuanmeiViewController *chuanmeiVC=[[ChuanmeiViewController alloc]init];
    chuanmeiVC.vcType=music;
    [self.navigationController pushViewController:chuanmeiVC animated:YES];
    chuanmeiVC=nil;
}

- (IBAction)meishuAction:(id)sender {
    ChuanmeiViewController *chuanmeiVC=[[ChuanmeiViewController alloc]init];
    chuanmeiVC.vcType=meishu;
    [self.navigationController pushViewController:chuanmeiVC animated:YES];
    chuanmeiVC=nil;
}
- (void)dealloc {
 
    [super dealloc];
}
@end
