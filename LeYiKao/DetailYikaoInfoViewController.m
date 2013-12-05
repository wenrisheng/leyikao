//
//  DetailYikaoInfoViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//
#import "UIAlertView+customShow.h"
#import "DetailYikaoInfoViewController.h"
#import "EnrollStuIntrolViewController.h"
#import "KaoshiAnpaiViewController.h"
#import "KaoshiNeirongViewController.h"
#import "WenhuaFenshuViewController.h"
#import "ZhuanyeFenshuViewController.h"
@interface DetailYikaoInfoViewController ()

@end

@implementation DetailYikaoInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoDao=[[InfoDao alloc]init];
        infoDao.delegate=self;
        
        collectDao=[[CollectDao alloc]init];
        collectDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [infoDao findInfoByYikaoId:self.schoolId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - InfoDaodelegate
-(void)findInfoByYikaoIdSuc:(id)value{
    NSLog(@"value:%@",value);
    dic=[value retain];
    _schoolLabel.text=[dic objectForKey:@"school"];
    _typeLabel.text=[dic objectForKey:@"schoolType"];
    _propertyLabel.text=[dic objectForKey:@"schoolNature"];
    _regionLabel.text=[dic objectForKey:@"province"];
    _levelLabel.text=[dic objectForKey:@"schoolLevel"];
    _telLabel.text=[dic objectForKey:@"telephone"];
}
-(void)findInfoByYikaoIdFail:(NSError *)error{
    [UIAlertView showWithTitle:nil message:@"加载失败" time:2];
}
- (void)dealloc {
    dic=nil;
    _schoolLabel=nil;
    infoDao=nil;

    [_schoolLabel release];


    [_typeLabel release];
    [_propertyLabel release];
    [_regionLabel release];
    [_levelLabel release];
    [_telLabel release];

    [super dealloc];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)colectAction:(id)sender {
    NSString *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId&&userId.length>0) {
    
        [collectDao collectByUserId:userId module:@"exam_info" id:_schoolId];
        
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

- (IBAction)introlAction:(id)sender {
    EnrollStuIntrolViewController *enrollVC=[[EnrollStuIntrolViewController alloc]init];
    enrollVC.str=[dic objectForKey:@"enrollmentGuide"];
    [self.navigationController pushViewController:enrollVC animated:YES];
    enrollVC=nil;
}

- (IBAction)anpaiAction:(id)sender {
    KaoshiAnpaiViewController *anpanVC=[[KaoshiAnpaiViewController alloc]init];
    anpanVC.str=[dic objectForKey:@"examSchedule"];
    [self.navigationController pushViewController:anpanVC animated:YES];
    anpanVC=nil;
}

- (IBAction)contentAction:(id)sender {
    KaoshiNeirongViewController *neirongVC=[[KaoshiNeirongViewController alloc]init];
    neirongVC.str=[dic objectForKey:@"examContent"];
    [self.navigationController pushViewController:neirongVC animated:YES];
    neirongVC=nil;
}

- (IBAction)wenhuaGradeAction:(id)sender {
    WenhuaFenshuViewController *wenhuaVC=[[WenhuaFenshuViewController alloc]init];
    wenhuaVC.str=[dic objectForKey:@"culturalScore"];
    [self.navigationController pushViewController:wenhuaVC animated:YES];
    wenhuaVC=nil;
}
- (IBAction)profGradeAction:(id)sender {
    ZhuanyeFenshuViewController *zhuanyeFenshuVC=[[ZhuanyeFenshuViewController alloc] init];
    zhuanyeFenshuVC.str=[dic objectForKey:@"specialtyScore"];
    [self.navigationController pushViewController:zhuanyeFenshuVC animated:YES];
    zhuanyeFenshuVC=nil;
}
@end
