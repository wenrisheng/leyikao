//
//  DetailActivityViewController.m
//  LeYiKao
//
//  Created by athudong on 13-11-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "DetailActivityViewController.h"
#import "UIAlertView+ShowShortMessage.h"
#import "ReplyCell.h"
@interface DetailActivityViewController ()

@end

@implementation DetailActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        communityDao=[[CommunityDao alloc]init];
        communityDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [communityDao findDetailActivityByActivityId:_activityId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [dataArray release];
    [communityDao release];
    [_activityId release];
    [_titleLabel release];
    [_contentLabel release];
    [_table release];
    [_jiaruLabel release];
    [_dianjiLabel release];
    [_huifuLabel release];
    [_timeLabel release];
    [_liuyanView release];
    [_textView release];
    [super dealloc];
}
#pragma mark - communityDaoDelegate
-(void)findDetailActivityByActivityIdSuc:(id)value{
    NSDictionary *dic=value;
    NSDictionary *actDic=[dic objectForKey:@"activity"];
    _jiaruLabel.text=[NSString stringWithFormat:@"已参加:%@",[actDic objectForKey:@"applies"]];
    _dianjiLabel.text=[NSString stringWithFormat:@"点击:%@",[actDic objectForKey:@"hits"]];
    _huifuLabel.text=[NSString stringWithFormat:@"回复:%@",[actDic objectForKey:@"replies"]];
    _timeLabel.text=[actDic objectForKey:@"updateTime"];
    _titleLabel.text=[actDic objectForKey:@"title"];
    _contentLabel.text=[actDic objectForKey:@"content"];
    dataArray=[[dic objectForKey:@"replies"] retain];
    [_table reloadData];
}
-(void)findDetailActivityByActivityIdFail:(NSError *)error{
    [UIAlertView showMessageWithTitle:Nil message:@"出错了" timeInterval:2];
}
-(void)baomingActivityWithUSSuc:(id)value{
     [UIAlertView showMessageWithTitle:Nil message:@"报名成功" timeInterval:2];
}
-(void)baomingActivityWithUSFail:(NSError *)error{
    [UIAlertView showMessageWithTitle:Nil message:@"报名出错" timeInterval:2];
}
-(void)liuyanWithUCSuc:(id)value{
     [UIAlertView showMessageWithTitle:Nil message:@"留言成功" timeInterval:2];
}
-(void)liuyanWithUCFail:(NSError *)error{
  [UIAlertView showMessageWithTitle:Nil message:@"留言出错" timeInterval:2];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _liuyanView.frame=CGRectMake(-320, _liuyanView.frame.origin.y, _liuyanView.frame.size.width, _liuyanView.frame.size.height);
    [UIView commitAnimations];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"ReplyCell" owner:nil options:nil];
        cell=[array objectAtIndex:0];
    }
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    cell.userLabel.text=[dic objectForKey:@"userId"];
    cell.createLabel.text=[dic objectForKey:@"createTime"];
    cell.contentTextView.text=[dic objectForKey:@"content"];
    return cell;
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)liuyanAction:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _liuyanView.frame=CGRectMake(0, _liuyanView.frame.origin.y, _liuyanView.frame.size.width, _liuyanView.frame.size.height);
    [UIView commitAnimations];
}

- (IBAction)enterAction:(id)sender {
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
         if (userId==nil) {
        [UIAlertView showMessageWithTitle:nil message:@"请先登陆" timeInterval:2];
    }else{
        [communityDao baomingActivityWithUserId:@"1234" activityId:_activityId];
    }
}
- (IBAction)liuyanButtonAction:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _liuyanView.frame=CGRectMake(-320, _liuyanView.frame.origin.y, _liuyanView.frame.size.width, _liuyanView.frame.size.height);
    [UIView commitAnimations];
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    if (userId==nil) {
        [UIAlertView showMessageWithTitle:nil message:@"请先登陆" timeInterval:2];
    }else{
        [communityDao liuyanWithUserId:userId activityId:_activityId content:_textView.text];
    }

}
@end
