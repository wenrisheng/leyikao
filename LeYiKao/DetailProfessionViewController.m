//
//  DetailProfessionViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "DetailProfessionViewController.h"

@interface DetailProfessionViewController ()

@end

@implementation DetailProfessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        professionDao=[[ProfessionDao alloc]init];
        professionDao.delegate=self;
        
        collectDao=[[CollectDao alloc]init];
        collectDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [professionDao getDetailProfessionByProId:self.proId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [collectDao release];
    [_proId release];
    [_typeLabel release];

    [_jianjieTextView release];
    [_contentTextView release];
    [super dealloc];
}
#pragma mark  - proDelegate
-(void)getDetailProfessionByProIdSuc:(id)value{
    NSDictionary *dic=value;
    _typeLabel.text=[dic objectForKey:@"name"];
    _jianjieTextView.text=[dic objectForKey:@"intro"];
    _contentTextView.text=[dic objectForKey:@"objective"];
    
}
-(void)getDetailProfessionByProIdFail:(NSError *)error{
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)collectAction:(id)sender {
    NSString *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId&&userId.length>0) {
        [collectDao collectByUserId:userId module:@"specialty" id:_proId];
        
    }else{
        [self showAlertViewWithMessage:@"请先登陆" time:1];
    }
    
}
#pragma mark - CollectionDaoDelegate

-(void)collectByUMIFail:(NSError *)error{
    [self showAlertViewWithMessage:@"收藏失败" time:1];
}
-(void)collectByUMISuc:(id)value{
    [self showAlertViewWithMessage:@"收藏成功" time:1];
}
-(void)showAlertViewWithMessage:(NSString *)message time:(float)time{
    UIAlertView *alertView=[[UIAlertView alloc]init];
    alertView.message=message;
    [alertView show];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(dismissAlertView:) userInfo:alertView repeats:NO];
    [alertView release];
}
-(void)dismissAlertView:(NSTimer *)timer{
    [(UIAlertView*) timer.userInfo  dismissWithClickedButtonIndex:0 animated:YES];
    
}

@end
