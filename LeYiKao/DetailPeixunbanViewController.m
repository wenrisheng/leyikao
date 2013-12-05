//
//  DetailPeixunbanViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-22.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "DetailPeixunbanViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIAlertView+customShow.h"
#import "PeixunbanPinglunCell.h"
#import "PinglunViewController.h"
@interface DetailPeixunbanViewController ()

@end

@implementation DetailPeixunbanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        peixunbanDao=[[PeixunbanDao alloc]init];
        peixunbanDao.delegate=self;
        
        collectDao=[[CollectDao alloc]init];
        collectDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [peixunbanDao findPeixunbanById:_peixunbanId];
    }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [peixunbanDao findPeixunbanPinglunById:_peixunbanId];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [dataArray release];
    peixunbanDao=nil;
    _peixunbanId=nil;
    [dic release];
    [_titleLabel release];
    [_imageView1 release];
    [_imageView2 release];

    [_table release];
    [super dealloc];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (dataArray) {
        return dataArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PeixunbanPinglunCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"PeixunbanPinglun" owner:nil options:nil];
        cell=[array objectAtIndex:0];
    }
    NSDictionary *dicc=[dataArray objectAtIndex:indexPath.row];
    cell.contentLabel.text=[dicc objectForKey:@"content"];
    cell.userLabel.text=[dicc objectForKey:@"userId"];
    cell.timeLabel.text=[dicc objectForKey:@"createTime"];
    return cell;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)findPeixunbanByIdSuc:(id)value{
   dic=[value retain];

    _titleLabel.text=[dic objectForKey:@"name"];
    [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",zuixinzixunurl,[dic objectForKey:@"imgName1"]]] placeholderImage:[UIImage imageNamed:@"logo.png"]];
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",zuixinzixunurl,[dic objectForKey:@"imgName2"]]] placeholderImage:[UIImage imageNamed:@"logo.png"]];

    
}
-(void)findPeixunbanByIdFail:(NSError *)error{
    [UIAlertView showWithTitle:nil message:@"网络不给力" time:2];
}
-(void)findPeixunbanPinglunByIdSuc:(id)value{
   
    dataArray=[value retain];
    [_table reloadData];
}
-(void)findPeixunbanPinglunByIdFail:(NSError *)error{
     [UIAlertView showWithTitle:nil message:@"网络不给力" time:2];
    
}
- (IBAction)telAction:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dic objectForKey:@"telephone"]]]];
   
}

- (IBAction)pinglunAction:(id)sender {
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId==nil) {
        [UIAlertView showWithTitle:nil message:@"请先登陆" time:2];
    }else{
        PinglunViewController *pinglunVC=[[PinglunViewController alloc]init];
        pinglunVC.trainingId=_peixunbanId;
        [self.navigationController pushViewController:pinglunVC animated:YES];
        [pinglunVC release];
    }
}

- (IBAction)collectAction:(id)sender {
    NSString *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId&&userId.length>0) {
        [collectDao collectByUserId:userId module:@"training" id:_peixunbanId];
        
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
