//
//  MoreViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "MoreViewController.h"
#import "MainViewController.h"
#import "AboutusViewController.h"
#import "CollectionViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myCellectionAction:(id)sender {
    CollectionViewController *collectionVC=[[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
    collectionVC=nil;
}

- (IBAction)shareWithFriendAction:(id)sender {
    
    NSString *str=@"大家一起参与乐艺考";
    UIImage *image=[UIImage imageNamed:@"logo"];
    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *items=@[str,image,url];
    UIActivityViewController *activityVC=[[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityVC.excludedActivityTypes=@[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
  [self presentViewController:activityVC animated:YES completion:^{
     
  }];
    
}

- (IBAction)exanintUpdateAction:(id)sender {
}

- (IBAction)aboutUsAction:(id)sender {
    AboutusViewController *aboutusVC=[[AboutusViewController alloc]init];
    [self.navigationController pushViewController:aboutusVC animated:YES];
    
    aboutusVC=nil;
}

- (IBAction)logoutAction:(id)sender {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出登陆吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    alertView=nil;;
    

}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"tel"];
        MainViewController *rootVC=[self.navigationController.viewControllers objectAtIndex:0];
        rootVC.isLogoutAfter=TRUE;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
- (void)dealloc {
    
    [super dealloc];
}
@end
