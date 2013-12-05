//
//  UserDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "UserDao.h"

@implementation UserDao

-(void)loginByTelephone:(NSString *)tel password:(NSString *)password{
    NSString *urlStr=[NSString stringWithFormat:@"%@/index.php?c=user&m=login&telephone=%@&password=%@",baseURL,tel,password];

    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.tag=kLogin;
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)registerUser:(User *)user{
      NSString *urlStr=[NSString stringWithFormat:@"%@/index.php?c=user&m=register",baseURL];
    NSURL *url=[NSURL URLWithString:urlStr];

    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:user.tel forKey:@"telephone"];
    [request setPostValue:user.password forKey:@"password"];
    [request setPostValue:user.grade forKey:@"grade"];
    [request setPostValue:user.profession forKey:@"specialtyType"];
    request.tag=kRegister;
    [request setDelegate:self];
    [request startAsynchronous];

}
#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    UserActionType userActionType=request.tag;
    switch (userActionType) {
        case kLogin:
        {
            NSString *result=[request responseString];
            NSLog(@"result:%@",result);
            if ([result isEqualToString:@"NOT_REGISTER"]) {
                [_delegate LoginFail:nil];
            }else{
                NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
                [_delegate loginSuc:dic];
            }
 
        }
            break;
        case kRegister:{
            [_delegate registerSuc:nil];
        }
        default:
            break;
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    UserActionType userActionType=request.tag;
    switch (userActionType) {
        case kLogin:
        {
            [_delegate LoginFail:nil];
        }
            break;
        case kRegister:
        {
            [_delegate registerFail:nil];
        }
            break;
        default:
            break;
    }
 
}
@end
