//
//  MainViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "User.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isLogoutAfter=NO;
        
        userDao=[[UserDao alloc] init];
        userDao.delegate=self;
        alertView=[[UIAlertView alloc] init];

        aiView=[[MBProgressHUD alloc]initWithFrame:CGRectMake((UIScreenWidth-50)*0.5, (UIScreenHeight-50)*0.5, 50, 50)];
        
    
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   //调用QQ登陆
    NSArray *permissions=[NSArray arrayWithObjects:
                          kOPEN_PERMISSION_GET_USER_INFO,
                          kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                          kOPEN_PERMISSION_ADD_ALBUM,
                          kOPEN_PERMISSION_ADD_IDOL,
                          kOPEN_PERMISSION_ADD_ONE_BLOG,
                          kOPEN_PERMISSION_ADD_PIC_T,
                          kOPEN_PERMISSION_ADD_SHARE,
                          kOPEN_PERMISSION_ADD_TOPIC,
                          kOPEN_PERMISSION_CHECK_PAGE_FANS,
                          kOPEN_PERMISSION_DEL_IDOL,
                          kOPEN_PERMISSION_DEL_T,
                          kOPEN_PERMISSION_GET_FANSLIST,
                          kOPEN_PERMISSION_GET_IDOLLIST,
                          kOPEN_PERMISSION_GET_INFO,
                          kOPEN_PERMISSION_GET_OTHER_INFO,
                          kOPEN_PERMISSION_GET_REPOST_LIST,
                          kOPEN_PERMISSION_LIST_ALBUM,
                          kOPEN_PERMISSION_UPLOAD_PIC,
                          kOPEN_PERMISSION_GET_VIP_INFO,
                          kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                          kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                          kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                          nil];
    [tencentOAuth authorize:permissions inSafari:NO];
    
    self.navigationController.navigationBarHidden=YES;

    [self.view addSubview:aiView];

    
    
    UIImage *btnImage=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"填充-01" ofType:@"png"]];
    [_loginButton setBackgroundImage:btnImage forState:UIControlStateHighlighted];

        [_registerButton setBackgroundImage:btnImage forState:UIControlStateHighlighted];
    btnImage=nil;
    //
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showMidView) userInfo:nil repeats:NO];
    //年级单选按钮
    gradeRadioGroup=[[RadioGroup alloc] init];
    gradeRadioGroup.delegate=self;
    gradeRadioGroup.tag=1;
    RadioButton *gradeButton1=[[RadioButton alloc] initWithFrame:CGRectMake(84, 158, 25, 28)];
    gradeButton1.checked=YES;
    gradeButton1.value=@"高一";
     RadioButton *gradeButton2=[[RadioButton alloc] initWithFrame:CGRectMake(156, 158, 25, 28)];
    gradeButton2.value=@"高二";
    gradeButton2.checked=NO;
     RadioButton *gradeButton3=[[RadioButton alloc] initWithFrame:CGRectMake(230, 158, 25, 28)];
    gradeButton3.value=@"高三";
    gradeButton3.checked=NO;
    NSArray *gradeArray=@[gradeButton1,gradeButton2,gradeButton3];
    for (RadioButton *radioButton in gradeArray) {
        [_registerView addSubview:radioButton];
        [gradeRadioGroup addRadioButton:radioButton];
        [radioButton release];
    }
    //专业单选按钮
    professionRadioGroup=[[RadioGroup alloc] init];
    professionRadioGroup.delegate=self;
    professionRadioGroup.tag=2;
    RadioButton *profButton1=[[RadioButton alloc] initWithFrame:CGRectMake(84, 217, 25, 28)];
    profButton1.checked=YES;
    profButton1.value=@"传媒";
    RadioButton *profButton2=[[RadioButton alloc] initWithFrame:CGRectMake(156, 217, 25, 28)];
    profButton2.value=@"音乐";
    profButton2.checked=NO;
    RadioButton *profButton3=[[RadioButton alloc] initWithFrame:CGRectMake(230, 217, 25, 28)];
    profButton3.value=@"美术";
    profButton3.checked=NO;
    NSArray *profArray=@[profButton1,profButton2,profButton3];
    for (RadioButton *radioButton in profArray) {
        [_registerView addSubview:radioButton];
        [professionRadioGroup addRadioButton:radioButton];
        [radioButton release];
    }

    
    //qq登陆
    NSString *appidd=@"222222";
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:appidd andDelegate:self];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (_isLogoutAfter) {
        
        _loginTelTextField.text=nil;
        _loginPasswrodTextField.text=nil;
    }
    [super viewWillAppear:animated];
}
-(void)showAlertViewWithMessage:(NSString *)message time:(float)time{
    alertView.message=message;
    [alertView show];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(dismissAlertView:) userInfo:alertView repeats:NO];
}
-(void)dismissAlertView:(NSTimer *)timer{
    [(UIAlertView*) timer.userInfo  dismissWithClickedButtonIndex:0 animated:YES];

}
-(void)showMidView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1];
    _midView.frame=CGRectMake(0, (UIScreenHeight-300)*0.5, UIScreenWidth, 319);
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_loginTelTextField resignFirstResponder];
    [_loginPasswrodTextField resignFirstResponder];
    [_registerTelTextField resignFirstResponder];
    [_registerPasswordTextField resignFirstResponder];
    [_registerConfirmPasswordTextField resignFirstResponder];
    
}
- (void)dealloc {
    aiView=nil;
    alertView=nil;
    userDao=nil;
    gradeRadioGroup=nil;
    professionRadioGroup=nil;
    
    [_loginTelTextField release];
    [_loginPasswrodTextField release];
    [_registerTelTextField release];
    [_registerPasswordTextField release];
    [_registerPasswordTextField release];
    [_registerConfirmPasswordTextField release];
    [_loginView release];
    [_registerView release];
    [_midView release];
    [_bgImageView release];
    [_loginButton release];
    [_registerButton release];
    [super dealloc];
}
- (IBAction)loginAction:(id)sender {

//    NSString *tel=_loginTelTextField.text;
//    NSString *pwd=_loginPasswrodTextField.text;
//    NSLog(@"tel:%@ pwd:%@",tel,pwd);
//        if (tel&&tel.length>0&&pwd&&pwd.length>0) {
//            [aiView show:YES];
//
//            [userDao loginByTelephone:tel password:pwd];
//          
//            
//        }else{
//            [self showAlertViewWithMessage:@"电话或密码不能为空" time:1];
//        }
   }

- (IBAction)registerAcion:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5];
    _loginView.frame=CGRectMake(-320, _loginView.frame.origin.y, _loginView.frame.size.width, _loginView.frame.size.height);
    _registerView.frame=CGRectMake(0, _registerView.frame.origin.y, _registerView.frame.size.width, _registerView.frame.size.height);
     [UIView commitAnimations];
}
- (IBAction)registerEndActioin:(id)sender {
    NSString *tel=_registerTelTextField.text;
    if (tel&&tel.length>0) {
        NSString *password=_registerPasswordTextField.text;
        NSString *confirmPassword=_registerConfirmPasswordTextField.text;
        if ([password isEqualToString:confirmPassword]) {
            
           [aiView show:YES];
            User *user=[[User alloc]init];
            user.tel=tel;
            user.password=password;
            user.grade=registerGrade;
            user.profession=registerProfession;
            [userDao registerUser:user];
            [user release];
        }else{
             [self showAlertViewWithMessage:@"密码不一致" time:1];
        }
    }else{
        [self showAlertViewWithMessage:@"注册电话不能为空" time:1];
    }
   
    

}

- (IBAction)backAction:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5];
    _loginView.frame=CGRectMake(0, _loginView.frame.origin.y, _loginView.frame.size.width, _loginView.frame.size.height);
    _registerView.frame=CGRectMake(640, _registerView.frame.origin.y, _registerView.frame.size.width, _registerView.frame.size.height);
    [UIView commitAnimations];
}
#pragma mark - RadioGroupChange
-(void)radioGroupChange:(RadioGroup *)sender{
    int tag=sender.tag;
    if (tag==1) {
        registerGrade=sender.value;
    }
    if (tag==2) {
        registerProfession=sender.value;
    }
    NSLog(@"value:%@",sender.value);
}
#pragma mark - UserDaoDelegate
-(void)loginSuc:(id)value{
   
    [aiView hide:YES];
    
        NSDictionary *dic=value;

        [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"telephone"]forKey:@"userId"];
    HomeViewController *homeVC=[[HomeViewController alloc]init];
    [self.navigationController pushViewController:homeVC animated:YES];
    homeVC=nil;
    NSLog(@"login suc");
    
}
-(void)LoginFail:(NSError *)error{
    [aiView hide:YES];
     [self showAlertViewWithMessage:@"网络出错" time:2];
     NSLog(@"login fail");
}
-(void)registerSuc:(id)value{
    [aiView hide:YES];
    [self showAlertViewWithMessage:@"注册成功" time:1];
    [[NSUserDefaults standardUserDefaults] setObject:_registerTelTextField.text forKey:@"tel"];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5];
    _loginView.frame=CGRectMake(0, _loginView.frame.origin.y, _loginView.frame.size.width, _loginView.frame.size.height);
    _registerView.frame=CGRectMake(640, _registerView.frame.origin.y, _registerView.frame.size.width, _registerView.frame.size.height);
    [UIView commitAnimations];
}
-(void)registerFail:(NSError *)error{
      [aiView hide:YES];
      [self showAlertViewWithMessage:@"注册失败" time:1];
}
#pragma mark - TencentSessionDelegate
-(void)tencentDidLogin{
    NSLog(@"tencentDidLogin");
    [tencentOAuth getUserInfo];
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if (!cancelled) {
        [self showAlertViewWithMessage:@"登陆失败" time:1];
    }
      NSLog(@"tencentDidNotLogin");
}
-(void)tencentDidNotNetWork{
    [self showAlertViewWithMessage:@"网络连接失败" time:1];
  

}
-(void)tencentDidLogout{
       NSLog(@"tencentDidLogout");
}
-(void)getUserInfoResponse:(APIResponse *)response{
    if (response.retCode==URLREQUEST_SUCCEED) {
        NSDictionary *dic=response.jsonResponse;
        NSLog(@"dic:%@",dic);
    }
}
@end
