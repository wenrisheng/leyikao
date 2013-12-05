//
//  HomeViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "HomeViewController.h"
#import "MoreViewController.h"
#import "RichenganpaiViewController.h"
#import "YikaoCommunityViewController.h"
#import "YikaoInfoViewController.h"
#import "PeixunbanViewController.h"
#import "ProfessionIntroduceViewController.h"
#import "ZuixinZixunView.h"
#import "DetailZixunViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isLeft=NO;
        currentPage=1;
        totalPage=4;
        communityDao=[[CommunityDao alloc] init];
        communityDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [communityDao findZuixinZixun];
    // Do any additional setup after loading the view from its nib.
   //  _bigScrollView.contentSize=CGSizeMake(640, UIScreenHeight);
    [_bigScrollView setContentSize:CGSizeMake(640, _bigScrollView.frame.size.height)];
    _bigScrollView.alwaysBounceVertical=NO;
    _bigScrollView.alwaysBounceHorizontal=NO;
    [_bigScrollView setContentOffset:CGPointMake(270, 0)];
  //  _bigScrollView.scrollEnabled=NO;
   // _bigScrollView.pagingEnabled=YES;

  
        NSLog(@"smalScrl consize width:%f  height:%f:",_smallScrollView.contentSize.width,_smallScrollView.contentSize.height);
  //////////////test
    for (int i=0; i<4; i++) {
        
        ZuixinZixunView *zuixinZixunView=[[ZuixinZixunView alloc]initWithFrame:CGRectMake(i*_smallScrollView.frame.size.width, 0, _smallScrollView.frame.size.width, _smallScrollView.frame.size.height)];
        
        [zuixinZixunView.smallView1.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
         [zuixinZixunView.smallView2.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
         [zuixinZixunView.smallView3.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [zuixinZixunView.smallView4.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
         [zuixinZixunView.smallView5.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_smallScrollView addSubview:zuixinZixunView];
        
        zuixinZixunView=nil;
        
    }

    _smallScrollView.contentSize=CGSizeMake(_smallScrollView.frame.size.width*4,_smallScrollView.frame.size.height);

    _smallScrollView.contentSize=CGSizeMake(_smallScrollView.frame.size.width*4, _smallScrollView.frame.size.height);
          }

-(void)buttonAction:(UIButton *)button{
    NSLog(@"buttonAction tag:%d",button.tag);
   DetailZixunViewController *detailVC=[[DetailZixunViewController alloc] init];
    detailVC.zixunId=[NSString stringWithFormat:@"%d",button.tag];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC=nil;
}
-(void)viewWillAppear:(BOOL)animated{
       self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)topButtonAction:(id)sender {
    NSLog(@"topbuttonAction");
    if (isLeft) {
        [_bigScrollView setContentOffset:CGPointMake(270, 0) animated:YES];
        isLeft=NO;
    }else{
     [_bigScrollView setContentOffset:CGPointMake(0, 0) animated:YES];


        isLeft=YES;
    }
   
}
- (void)dealloc {
    communityDao=nil;
    [_bigScrollView release];
    [_smallScrollView release];
    [_oneModelView release];
 
    [_threeModelView release];
 
    [super dealloc];
}
- (IBAction)professionIntroduceAction:(id)sender {
    ProfessionIntroduceViewController *piVC=[[ProfessionIntroduceViewController alloc] init];
    [self.navigationController pushViewController:piVC animated:YES];
    piVC=nil;
}

- (IBAction)peixunbanAction:(id)sender {
    PeixunbanViewController *pxVC=[[PeixunbanViewController alloc] init];
    [self.navigationController pushViewController:pxVC animated:YES];
    pxVC=nil;
}

- (IBAction)yikaoInfoAction:(id)sender {
    YikaoInfoViewController *yiVC=[[YikaoInfoViewController alloc] init];
    [self.navigationController pushViewController:yiVC animated:YES];
    yiVC=nil;
}

- (IBAction)yikaoCommunityAction:(id)sender {
    YikaoCommunityViewController *ycVC=[[YikaoCommunityViewController alloc] init];
    [self.navigationController pushViewController:ycVC animated:YES];
    ycVC=nil;
}

- (IBAction)richengaipaiAction:(id)sender {
    RichenganpaiViewController *raVC=[[RichenganpaiViewController alloc] init];
    [self.navigationController pushViewController:raVC animated:YES];
    raVC=nil;
}

- (IBAction)moreAction:(id)sender {
    MoreViewController *moreVC=[[MoreViewController alloc] init];
    [self.navigationController pushViewController:moreVC animated:YES];
    moreVC=nil;
}
#pragma mark - communityDaoDelegate
-(void)findZuixinZixunSuc:(id)value{
    NSArray *array=value;
    NSArray *subViews=[_smallScrollView subviews];

    for (int i=0; i<4; i++) {
        int k=i*6;
        NSDictionary *dic0=[array objectAtIndex:k];
         NSDictionary *dic1=[array objectAtIndex:k+1];
         NSDictionary *dic2=[array objectAtIndex:k+2];
         NSDictionary *dic3=[array objectAtIndex:k+3];
         NSDictionary *dic4=[array objectAtIndex:k+4];
         NSDictionary *dic5=[array objectAtIndex:k+5];
        ZuixinZixunView *zuixinView=[subViews objectAtIndex:i];
        NSString *imageUrlStr=[NSString stringWithFormat:@"%@/%@",zuixinzixunurl,[dic0 objectForKey:@"picture"]];

        [zuixinView.imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"wait.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error) {
                NSLog(@"error:%@",error);
            }
        
        }];
//        UIImage *image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]]];
//        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, zuixinView.imagesScrollView.frame.size.width, zuixinView.imagesScrollView.frame.size.height)];
//        imageView.image=image;
//              image=nil;
//        imageView=nil;
     //   zuixinView.imageView.image=image;

  

        //1
          [zuixinView.smallView1.button setTitle:[dic1 objectForKey:@"title"] forState:UIControlStateNormal];
        zuixinView.smallView1.button.tag=[[dic1 objectForKey:@"id"] intValue];
        zuixinView.smallView1.timeLabel.text=[dic1 objectForKey:@"date"];
        //2
        [zuixinView.smallView2.button setTitle:[dic2 objectForKey:@"title"] forState:UIControlStateNormal];
        zuixinView.smallView2.button.tag=[[dic2 objectForKey:@"id"] intValue];
        zuixinView.smallView2.timeLabel.text=[dic2 objectForKey:@"date"];
        //3
        [zuixinView.smallView3.button setTitle:[dic3 objectForKey:@"title"] forState:UIControlStateNormal];
        zuixinView.smallView3.button.tag=[[dic3 objectForKey:@"id"] intValue];
        zuixinView.smallView3.timeLabel.text=[dic3 objectForKey:@"date"];
        //4
        [zuixinView.smallView4.button setTitle:[dic4 objectForKey:@"title"] forState:UIControlStateNormal];
        zuixinView.smallView4.button.tag=[[dic4 objectForKey:@"id"] intValue];
        zuixinView.smallView4.timeLabel.text=[dic4 objectForKey:@"date"];
        //5
        [zuixinView.smallView5.button setTitle:[dic5 objectForKey:@"title"] forState:UIControlStateNormal];
        zuixinView.smallView5.button.tag=[[dic5 objectForKey:@"id"] intValue];
        zuixinView.smallView5.timeLabel.text=[dic5 objectForKey:@"date"];
    }
}
-(void)findZuixinZixunFail:(NSError *)error{
    
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"网络请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}
@end
