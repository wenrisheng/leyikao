//
//  InfoDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-23.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "InfoDao.h"
#import "ASIHTTPRequest.h"
@implementation InfoDao
-(void)findInfoByProvinceId:(NSString *)provinceId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=exam_info&m=page&province=%@",baseURL,provinceId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    [request setCompletionBlock:^{
        NSArray *array= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findInfoByProvinceIdSuc:array];
        
    }];
    [request setFailedBlock:^{
        [_delegate findInfoByProvinceIdFail:nil];
    }];
    [request startAsynchronous];

}
-(void)findInfoByYikaoId:(NSString *)yikaoId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=exam_info&m=view&id=%@",baseURL,yikaoId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findInfoByYikaoIdSuc:dic];
        
    }];
    [request setFailedBlock:^{
        [_delegate findInfoByYikaoIdFail:nil];
    }];
    [request startAsynchronous];
}
@end
