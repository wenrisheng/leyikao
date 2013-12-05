//
//  CollectionViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectCell.h"
#import "DetailZixunViewController.h"
#import "DetailProfessionViewController.h"
#import "DetailYikaoInfoViewController.h"
#import "DetailPeixunbanViewController.h"
#import "DetailCommunityViewController.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        collectDao=[[CollectDao alloc]init];
        collectDao.delegate=self;
        isEdited=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId) {
        [collectDao findCollectsByUserId:userId pageNo:@"1" pageSize:@"20"];

    }else{
        
    }
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [dataArray release];
    [_table release];
    [super dealloc];
}
#pragma mark - uitableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 82;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"dataArray.count:%d",dataArray.count);
    return  dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *identify=@"cell";
    CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"CollectCell" owner:nil options:nil] ;
        cell=[array objectAtIndex:0];
    }
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    cell.modelLabel.text=[dic objectForKey:@"moduleName"];
    cell.contentLabel.text=[dic objectForKey:@"content"];
    cell.timeLabel.text=[dic objectForKey:@"createTime"];
    return  cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
     NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    [collectDao deleteCollectbyUserId:userId collectId:[dic objectForKey:@"id"]];
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    NSString *contentId=[dic objectForKey:@"contentId"];
    NSString *module=[dic objectForKey:@"moduleName"];
    if ([module isEqualToString:@"资讯"]) {
        DetailZixunViewController *zixunVC=[[DetailZixunViewController alloc]init];
        zixunVC.zixunId=contentId;
        [self.navigationController pushViewController:zixunVC animated:YES];
        [zixunVC release];
    }
    if ([module isEqualToString:@"专业"]) {
        DetailProfessionViewController *proVC=[[DetailProfessionViewController alloc]init];
        proVC.proId=contentId;
        [self.navigationController pushViewController:proVC animated:YES];
        [proVC release];
        
    }
    if ([module isEqualToString:@"艺考信息"]) {
        DetailYikaoInfoViewController *infoVC=[[DetailYikaoInfoViewController alloc]init];
        infoVC.schoolId=contentId;
        [self.navigationController pushViewController:infoVC animated:YES];
        [infoVC release];
    }
    if ([module isEqualToString:@"培训班"]) {
        DetailPeixunbanViewController *peixunbanVc=[[DetailPeixunbanViewController alloc]init];
        peixunbanVc.peixunbanId=contentId;
        [self.navigationController pushViewController:peixunbanVc animated:YES];
        [peixunbanVc release];
    }
    if ([module isEqualToString:@"论坛"]) {
        DetailCommunityViewController *communityVC=[[DetailCommunityViewController alloc]init];
        communityVC.postId=contentId;
        [self.navigationController pushViewController:communityVC animated:YES];
        [communityVC release];
    }
}
#pragma mark - CollectDaoDelegate
-(void)findCollectsByUPPSuc:(id)value{
    dataArray=[value retain];
    [_table reloadData];
    NSLog(@"dataArray:%@",dataArray);
}
-(void)findCollectsByUPPFail:(NSError *)error{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"查找收藏失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteActioin:(id)sender {
    if (!isEdited) {
        [_table setEditing:YES animated:YES];
        isEdited=YES;
    }else{
        [_table setEditing:NO animated:YES];
        isEdited=NO;
    }
   
}
#pragma mark - collectDaoDelegate
-(void)deleteCollectByUCFail:(NSError *)error{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"删除失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    
}
-(void)deleteCollectByUCSuc:(id)value{
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
           [collectDao findCollectsByUserId:userId pageNo:@"1" pageSize:@"20"];
  }
@end
