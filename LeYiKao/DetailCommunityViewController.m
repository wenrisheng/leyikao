//
//  DetailCommunityViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "DetailCommunityViewController.h"
#import "ReplyCell.h"
#import "WritePinglunViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIAlertView+customShow.h"

@interface DetailCommunityViewController ()

@end

@implementation DetailCommunityViewController

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
    _contentScrollVew.contentSize=CGSizeMake(UIScreenWidth,600);
        _imageScrollView.contentSize=CGSizeMake(640, _imageScrollView.frame.size.height);
   }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [communityDao findDetailZixuById:self.postId];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [dataArray release];
    self.postId=nil;
    communityDao=nil;
    [_userLabel release];
    [_titleLabel release];
    [_dianjiLabel release];
    [_replyLabel release];
    [_createlabel release];
    [_table release];
    [_contenTextView release];
    [_imageView release];
    [_contentScrollVew release];
    [_imageScrollView release];
    [super dealloc];
}
#pragma mark - uitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"cell";
    ReplyCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ReplyCell" owner:nil options:nil];
        cell=[array objectAtIndex:0];
    }
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.row+1];
    cell.userLabel.text=[dic objectForKey:@"userId"];
    cell.contentTextView.text=[dic objectForKey:@"content"];
    cell.createLabel.text=[dic objectForKey:@"createTime"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127;
}
#pragma mark - communityDelegate
-(void)findDetailZixuByIdSuc:(id)value{
    
    NSDictionary *dic=value;
    NSDictionary *userDic=[dic objectForKey:@"post"];
    _userLabel.text=[userDic objectForKey:@"userId"];
    _titleLabel.text=[userDic objectForKey:@"title"];
    _dianjiLabel.text=[NSString stringWithFormat:@"点击:%@",[userDic objectForKey:@"hits"]];
     _replyLabel.text=[NSString stringWithFormat:@"恢复:%@",[userDic objectForKey:@"replies"]];
     _createlabel.text=[NSString stringWithFormat:@"创建:%@",[userDic objectForKey:@"createTime"]];
    NSArray *imageArray=[userDic objectForKey:@"picture"];
    int count=imageArray.count;

    for (int i=0; i<count; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.frame=CGRectMake(i*_imageScrollView.frame.size.width*0.5, 0, _imageScrollView.frame.size.width*0.5, _imageScrollView.frame.size.height);
        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",zuixinzixunurl,[imageArray objectAtIndex:i]];
        NSLog(@"imageUrl:%@",imageUrl);
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
        }];
     [_imageScrollView addSubview:imageView];
        [imageView release];
    }
        dataArray=[[dic objectForKey:@"replies"] retain];
    NSDictionary *conDic=[dataArray objectAtIndex:0];
    _contenTextView.text=[conDic objectForKey:@"content"];
    [_table reloadData];
}
-(void)findDetailZixuByIdFail:(NSError *)error{
    [UIAlertView showWithTitle:Nil message:@"网络不给力" time:2];

}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)collectAction:(id)sender {
    NSString *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId&&userId.length>0) {
        [collectDao collectByUserId:userId module:@"forum" id:_postId];
        
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

- (IBAction)WritePinglunAction:(id)sender {
    WritePinglunViewController *writePinglunVC=[[WritePinglunViewController alloc]init];
    writePinglunVC.postId=_postId;
    [self.navigationController pushViewController:writePinglunVC animated:YES];
    [writePinglunVC release];
    
}
@end
