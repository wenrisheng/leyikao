//
//  DetailZixunViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-24.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "DetailZixunViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DetailZixunViewController ()

@end

@implementation DetailZixunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        communityDao=[[CommunityDao alloc]init];
        communityDao.delegate=self;
        
        collectDao=[[CollectDao alloc]init];
        collectDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [communityDao findDetailZuixinZixunByZixunId:_zixunId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    collectDao=nil;
    communityDao=nil;
    _zixunId=nil;
    [_titleLabel release];
    [_dateLabel release];
    [_introlLabel release];
    [_contentLabel release];
    [_imageView release];
    [dic release];
    [super dealloc];
}
#pragma mark - communityDaoDelegate
-(void)findDetailZuixinZixunByZixunIdSuc:(id)value{
    NSLog(@"value:%@",value);
   dic=value;
    _titleLabel.text=[dic objectForKey:@"title"];
    _dateLabel.text=[dic objectForKey:@"date"];
    _introlLabel.text=[dic objectForKey:@"concise_content"];
    _contentLabel.text=[dic objectForKey:@"detailed_content"];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",zuixinzixunurl,[dic objectForKey:@"picture"]]];
    [_imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo"]];
   
   
}
-(void)findDetailZuixinZixunByZixunIdFail:(NSError *)error{
    NSLog(@"findDetailZixuByIdFail");
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)collectAction:(id)sender {
   NSString *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId&&userId.length>0) {
    [collectDao collectByUserId:@"userId" module:@"news" id:_zixunId];

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
