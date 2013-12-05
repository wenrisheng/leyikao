//
//  ChuanmeiViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ChuanmeiViewController.h"
#import "DetailProfessionViewController.h"
#import "UIAlertView+customShow.h"
@interface ChuanmeiViewController ()

@end

@implementation ChuanmeiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        professionDao=[[ProfessionDao alloc]init];
        professionDao.delegate=self;
        dataArray=nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switch (self.vcType) {
        case 0:
        {
            _titleLabel.text=@"传媒";
           [professionDao getProfessionByType:@"1"];
        }
            break;
        case 1:
        {
             _titleLabel.text=@"音乐";
            [professionDao getProfessionByType:@"2"];
        }
            break;
        case 2:
        {
            _titleLabel.text=@"美术";
            [professionDao getProfessionByType:@"3"];
        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [dataArray release];
    [professionDao release];
    [_table release];
    [_titleLabel release];
    [_titleLabel release];
    [super dealloc];
}
#pragma mark - uitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *identify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
   
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row];
    DetailProfessionViewController *detailProVC=[[DetailProfessionViewController alloc]init];
       detailProVC.proId=[dic objectForKey:@"id"];
    [self.navigationController pushViewController:detailProVC animated:YES];
    detailProVC=Nil;

}
#pragma mark - peixunbanDaoDelegate
-(void)getProfessionByTypeSuc:(id)value{
    dataArray=[value retain];
    [_table reloadData];
}

-(void)getProfessionByTypeFail:(NSError *)error{
    [UIAlertView showWithTitle:nil message:@"网络出错" time:2];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
