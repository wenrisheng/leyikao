//
//  MainViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioGroup.h"
#import "UserDao.h"
#import "MBProgressHUD.h"
#import "UserDao.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface MainViewController : UIViewController<RadioGroupChange,UserDaoDelegate,TencentSessionDelegate>
{
    RadioGroup *gradeRadioGroup;
    RadioGroup *professionRadioGroup;
    
    UserDao *userDao;
    
    UIAlertView *alertView;

    MBProgressHUD *aiView;
    
    NSString *registerGrade;
    NSString *registerProfession;
   
    TencentOAuth *tencentOAuth;
}
@property(assign,nonatomic) BOOL *isLogoutAfter;
@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;

@property (retain, nonatomic) IBOutlet UIView *midView;


@property (retain, nonatomic) IBOutlet UIView *loginView;


@property (retain, nonatomic) IBOutlet UITextField *loginTelTextField;
@property (retain, nonatomic) IBOutlet UITextField *loginPasswrodTextField;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerAcion:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;



@property (retain, nonatomic) IBOutlet UIView *registerView;

@property (retain, nonatomic) IBOutlet UITextField *registerTelTextField;
@property (retain, nonatomic) IBOutlet UITextField *registerPasswordTextField;
@property (retain, nonatomic) IBOutlet UITextField *registerConfirmPasswordTextField;

- (IBAction)registerEndActioin:(id)sender;
- (IBAction)backAction:(id)sender;


@end
