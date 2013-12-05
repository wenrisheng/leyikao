//
//  PinglunViewController.m
//  LeYiKao
//
//  Created by athudong on 13-11-11.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "PinglunViewController.h"
#import "UIAlertView+customShow.h"
@interface PinglunViewController ()

@end

@implementation PinglunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        peixunbaiDao=[[PeixunbanDao alloc]init];
        peixunbaiDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CALayer *layer=_textView.layer;
    layer.cornerRadius=2;
    layer.borderColor=[[UIColor grayColor] CGColor];
    layer.borderWidth=1;

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_trainingId release];
    [_textView release];
    [super dealloc];
}
- (IBAction)fabiaoAction:(id)sender {
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId==nil) {
        [UIAlertView showWithTitle:nil message:@"请先登陆" time:2];
    }else{
        NSString *content=_textView.text;
        [peixunbaiDao fabiaoPeixunbanPinglunByUserId:userId trainingId:_trainingId Content:content];
    }

}
#pragma mark - PeixunbanDaoDelegate
-(void)fabiaoPeixunbanPinglunByUCSuc:(id)value{
    [UIAlertView showWithTitle:nil message:@"评论成功" time:2];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(popAction) userInfo:nil repeats:NO];
   
  }
-(void)popAction{
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)fabiaoPeixunbanPinglunByUCFail:(NSError *)error{
     [UIAlertView showWithTitle:nil message:@"评论失败" time:2];
}
@end
