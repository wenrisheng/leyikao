//
//  YikaoCommunityViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//
enum TableType {
    Community,
    Activity
};
typedef enum TableType TableType;
#import "YikaoCommunityViewController.h"
#import "YikaoCommunityCell.h"
#import "DetailCommunityViewController.h"
#import "WritePostViewController.h"
#import "UIAlertView+ShowShortMessage.h"
#import "ActivityCell.h"
#import "DetailActivityViewController.h"
@interface YikaoCommunityViewController ()

@end

@implementation YikaoCommunityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isRenqi=YES;
        communityDao=[[CommunityDao alloc]init];
        communityDao.delegate=self;
        
          aiView=[[MBProgressHUD alloc]initWithFrame:CGRectMake((UIScreenWidth-50)*0.5, (UIScreenHeight-50)*0.5, 50, 50)];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    [self.view addSubview:aiView];
    [ self initView];
    _table.tag=Community;
    _activityTable.tag=Activity;
}
-(void)initView{
    [aiView show:YES];
  [communityDao findZixunBypageNo:@"1" pageSize:@"20" sort:@"hot"];
    [communityDao findActivitiesByPageNo:@"1"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)writeAction:(id)sender {
    WritePostViewController *writePostVC=[[WritePostViewController alloc]init];
    [self.navigationController pushViewController:writePostVC animated:YES];
    writePostVC=nil;
}
- (void)dealloc {
    [activityArray release];
    aiView=nil;
    _dataArray=nil;
    [_table release];
    [_topImage release];
    [_activityView release];
    [_activityTable release];
    [super dealloc];
}
- (IBAction)refreshAction:(id)sender {
     [self performSelectorInBackground:@selector(initView) withObject:nil];
}
#pragma mark - uitableViewDatasourceDelegeate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag=tableView.tag;
    if (tag==Community) {
         return _dataArray.count;
    }else{
        return activityArray.count;
    }
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"cell";
      int tag=tableView.tag;
    if (tag==Community) {
        YikaoCommunityCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"YikaoCommunityCell" owner:nil options:nil];
            cell=[array objectAtIndex:0];
        }
        NSDictionary *dic=[_dataArray objectAtIndex:indexPath.row];
        cell.label.text=[dic objectForKey:@"title"];
        cell.writerLabel.text=[dic objectForKey:@"userId"];
        cell.dianjiLabel.text=[NSString stringWithFormat:@"点击:%@",[dic objectForKey:@"hits"]];
        cell.huifuLabel.text=[NSString stringWithFormat:@"恢复:%@",[dic objectForKey:@"replies"]];
        return cell;
    }else{
        ActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:nil options:nil];
            cell=[array objectAtIndex:0];
        }
        NSDictionary *dic=[activityArray objectAtIndex:indexPath.row];
        cell.titleLabel.text=[dic objectForKey:@"title"];
        cell.baomingNumLabel.text=[NSString stringWithFormat:@"已报名：%@",[dic objectForKey:@"applies"]];
        cell.dianjiLabel.text=[NSString stringWithFormat:@"点击:%@",[dic objectForKey:@"hits"]];
        cell.huifuLabel.text=[NSString stringWithFormat:@"恢复:%@",[dic objectForKey:@"replies"]];
        return cell;
 
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag=tableView.tag;
    if (tag==Community) {
        NSDictionary *dic=[_dataArray objectAtIndex:indexPath.row];
        DetailCommunityViewController *detailCommunityVC=[[DetailCommunityViewController alloc]init];
        detailCommunityVC.postId=[dic objectForKey:@"id"];
        [self.navigationController pushViewController:detailCommunityVC animated:YES];
        detailCommunityVC=nil;
    }else{
        NSDictionary *dic=[activityArray objectAtIndex:indexPath.row];
        DetailActivityViewController *detailActivityVC=[[DetailActivityViewController alloc]init];
        detailActivityVC.activityId=[dic objectForKey:@"id"];
        [self.navigationController pushViewController:detailActivityVC animated:YES];
        detailActivityVC=nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99;
}
- (IBAction)renqiAction:(id)sender {
    if (!isRenqi) {
        isRenqi=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        _topImage.frame=CGRectMake(68, _topImage.frame.origin.y, _topImage.frame.size.width, _topImage.frame.size.height);
        [UIView commitAnimations];
        _table.frame=CGRectMake(0,_table.frame.origin.y, _table.frame.size.width, _table.frame.size.height);
        _activityView.frame=CGRectMake(320, _activityView.frame.origin.y, _activityView.frame.size.width, _activityView.frame.size.height);
    }
}

- (IBAction)zuixinAction:(id)sender {
    if (isRenqi) {
        isRenqi=NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        _topImage.frame=CGRectMake(205, _topImage.frame.origin.y, _topImage.frame.size.width, _topImage.frame.size.height);
        [UIView commitAnimations];
        _table.frame=CGRectMake(-320,_table.frame.origin.y, _table.frame.size.width, _table.frame.size.height);
        _activityView.frame=CGRectMake(0, _activityView.frame.origin.y, _activityView.frame.size.width, _activityView.frame.size.height);
    }
}
#pragma mark - CommunityDaoDelegate
-(void)findZixunBypageNOSizeSortSuc:(id)value{
    _dataArray=[value retain];
    [aiView hide:YES];
       [_table reloadData];
}
-(void)findZixunBypageNOSizeSortFail:(NSError *)error{
    [aiView hide:YES];
    [UIAlertView showMessageWithTitle:nil message:@"网络不给力" timeInterval:2];
}
-(void)findActivitiesByPageNoSuc:(id)value{
    NSDictionary *dic=value;
    activityArray=[[dic objectForKey:@"activitys"] retain];
    [_activityTable reloadData];
}
-(void)findActivitiesByPageNoFail:(NSError *)error{
  [UIAlertView showMessageWithTitle:nil message:@"网络不给力" timeInterval:2];  
}
@end
