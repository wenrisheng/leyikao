//
//  ProfessionDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ProfessionDao.h"
#import "ASIHTTPRequest.h"
@implementation ProfessionDao
-(void)getProfessionByType:(NSString *)typeID{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=specialty&m=page&type=%@",baseURL,typeID];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate getProfessionByTypeSuc:[dic objectForKey:@"records"]];
        
    }];
    [request setFailedBlock:^{
        [_delegate getProfessionByTypeFail:nil];
    }];
    [request startAsynchronous];
}
-(void)getDetailProfessionByProId:(NSString *)proId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=specialty&m=view&id=%@",baseURL,proId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate getDetailProfessionByProIdSuc:dic];
        
    }];
    [request setFailedBlock:^{
        [_delegate getDetailProfessionByProIdFail:nil];
    }];
    [request startAsynchronous];
}
@end
