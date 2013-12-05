//
//  ProvinceYikaoInfoViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ProvinceYikaoInfoViewController.h"
#import "DetailYikaoInfoViewController.h"
@interface ProvinceYikaoInfoViewController ()

@end

@implementation ProvinceYikaoInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoDao=[[InfoDao alloc]init];
        infoDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [infoDao findInfoByProvinceId:_provinceId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    dataArray=nil;
    _provinceId=Nil;
    [_table release];
    [super dealloc];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -= uitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"school"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailYikaoInfoViewController *detailInfoVC=[[DetailYikaoInfoViewController alloc]init];
     NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    detailInfoVC.schoolId=[dic objectForKey:@"id"];
    NSLog(@"schoolId;%@",[dic objectForKey:@"id"]);
    [self.navigationController pushViewController:detailInfoVC animated:YES];
    detailInfoVC=nil;
}
#pragma mark - InfoDaoDelegate
-(void)findInfoByProvinceIdSuc:(id)value{

    dataArray=[value retain];
    [_table reloadData];
}
-(void)findInfoByProvinceIdFail:(NSError *)error{
    NSLog(@"findInfoByYikaoIdFail");
}
@end
