//
//  CollectDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-25.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "CollectDao.h"
#import "ASIFormDataRequest.h"
@implementation CollectDao
-(void)collectByUserId:(NSString *)userId module:(NSString *)module id:(NSString *)ID{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=favorite&m=add",baseURL];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];

    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:module forKey:@"module"];
    [request setPostValue:ID forKey:@"contentId"];
    [request setCompletionBlock:^{
       
       
        [_delegate collectByUMISuc:nil];
        
    }];
    [request setFailedBlock:^{
        [_delegate collectByUMIFail:nil];
    }];
    [request startAsynchronous];
}
-(void)findCollectsByUserId:(NSString *)userId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize{
    
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=favorite&m=page&userId=%@&pageNo=%@&pageSize=%@",baseURL,userId,pageNo,pageSize];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
       
        [_delegate findCollectsByUPPSuc:[dic objectForKey:@"records"]];
    }];
    [request setFailedBlock:^{
        [_delegate findCollectsByUPPFail:request.error];

    }];
    [request startAsynchronous];
}
-(void)deleteCollectbyUserId:(NSString *)userId collectId:(NSString *)collectId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=favorite&m=deleteFavorite&userId=%@&id=%@",baseURL,userId,collectId];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        [_delegate deleteCollectByUCSuc:nil];
    }];
    [request setFailedBlock:^{
        [_delegate deleteCollectByUCFail:nil];
    }];
    [request startAsynchronous];
}
@end
