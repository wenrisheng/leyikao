//
//  PeixunbanDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-19.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "PeixunbanDao.h"
#import "ASIHTTPRequest.h"
@implementation PeixunbanDao
-(void)findProvinces{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training&m=provinces",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    [request setCompletionBlock:^{
        NSArray *array=[NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findProvincesSuc:array];
        
          }];

   [request setFailedBlock:^{
       [_delegate findProvincesFail:nil];
   }];
    [request startAsynchronous];
}
-(void)findCities{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training&m=cities",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5];
    [request setCompletionBlock:^{
        NSArray *array= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        
        [_delegate findCitySuc:array];
        
    }];
    [request setFailedBlock:^{
        [_delegate findCityFail:nil];
    }];
    [request startAsynchronous];
}
-(void)findSpecialties{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training&m=specialties",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5];
    [request setCompletionBlock:^{
        NSArray *array= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findSpecialtySuc:array];
        
    }];
    [request setFailedBlock:^{
        [_delegate findSpecialtySuc:nil];
    }];
    [request startAsynchronous];
}
-(void)searchPeixunbanByProvince:(NSString *)province city:(NSString *)city specialty:(NSString *)spectalty keyword:(NSString *)keyword{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training&m=page&province=%@&city=%@&specialty=%@&name=%@",baseURL,province,city,spectalty,keyword];
   urlStr= [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url:%@",urlStr);
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        NSArray *arra=[dic objectForKey:@"records"];
        [_delegate searchPeisunbanByPCSSuc:arra];
        
    }];
    [request setFailedBlock:^{
        [_delegate searchPeisunbanByPCSFail:nil];
    }];
    [request startAsynchronous];

}
-(void)findPeixunbanById:(NSString *)peisunbanId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training&m=view&id=%@",baseURL,peisunbanId];

    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
               [_delegate findPeixunbanByIdSuc:dic];
        
    }];
    [request setFailedBlock:^{
        [_delegate findPeixunbanByIdFail:nil];
    }];
    [request startAsynchronous];

}
-(void)findPeixunbanPinglunById:(NSString *)peixunbanid{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training_reply&m=getReplies&trainingId=%@",baseURL,peixunbanid];
    
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findPeixunbanPinglunByIdSuc:dic];
        
    }];
    [request setFailedBlock:^{
        [_delegate findPeixunbanPinglunByIdFail:request.error];
    }];
    [request startAsynchronous];
}
-(void)fabiaoPeixunbanPinglunByUserId:(NSString *)userId trainingId:(NSString *)trainingId Content:(NSString *)peixunbanid;{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=training_reply&m=addReplies&trainingId=%@&userId=%@&content=%@",baseURL,trainingId,userId,peixunbanid];
    
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
                [_delegate fabiaoPeixunbanPinglunByUCSuc:nil];
        
    }];
    [request setFailedBlock:^{
        [_delegate fabiaoPeixunbanPinglunByUCFail:request.error];
    }];
    [request startAsynchronous];
}
@end
