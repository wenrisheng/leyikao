//
//  CommunityDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-18.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "CommunityDao.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
enum ZixunActionType{
    kGetZuixinZixuns,
    kGetZixuns,
    kDatailZixun,
    kCreateZixun,
    kReplyZixun
};
typedef enum ZixunActionType ZixunActionType;

@implementation CommunityDao
-(void)findZixunBypageNo:(NSString *)pageNo pageSize:(NSString *)pageSize sort:(NSString *)sort{
  
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=forum&m=pagePost&pageNo=%@&pageSize=%@&sort=%@",baseURL,pageNo,pageSize,sort];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.tag=kGetZixuns;
    [request setDelegate:self];
    [request startAsynchronous];
    
}
-(void)findZuixinZixun{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=news&m=GetAllNews",baseURL];

    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:10];
    request.tag=kGetZuixinZixuns;
//    [request setCompletionBlock:^{
//    NSData *data=[request responseData];
//    NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NO];
//    
//    [_delegate findZuixinZixunSuc:array];
//
//    }];
    [request setDelegate:self];
    [request setFailedBlock:^{
        [_delegate findZuixinZixunFail:nil];
    }];
    [request startAsynchronous];
}
-(void)findDetailZixuById:(NSString *)ID{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=forum&m=viewPost&postId=%@",baseURL,ID];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
 
    request.tag=kGetZuixinZixuns;
     [request setCompletionBlock:^{
         NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"dic:%@",dic);
         [_delegate findDetailZixuByIdSuc:dic];

    
    }];
[request setFailedBlock:^{
    [_delegate findDetailZixuByIdFail:request.error];
}];
    [request startAsynchronous];
}
-(void)findDetailZuixinZixunByZixunId:(NSString *)zixunId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=news&m=GetNewsDetailed&id=%@",baseURL,zixunId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    request.tag=kGetZuixinZixuns;
    [request setCompletionBlock:^{
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        [_delegate findDetailZuixinZixunByZixunIdSuc:dic];
        
        
    }];
    [request setFailedBlock:^{
        [_delegate findDetailZuixinZixunByZixunIdFail:request.error];
    }];
    [request startAsynchronous];

}
-(void)createPostWithUserId:(NSString *)userId title:(NSString *)title content:(NSString *)content image:(NSMutableArray *)imageData{
    int count=imageData.count;
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=forum&m=createPost",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];


    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:title forKey:@"title"];
    [request setPostValue:content forKey:@"content"];
    [request setPostValue:[NSString stringWithFormat:@"%d",count] forKey:@"pictureNum"];
    for (int i=0; i<count; i++) {
         [request setFile:[imageData objectAtIndex:i] withFileName:@"aaa.png" andContentType:@"image/jpeg" forKey:[NSString stringWithFormat:@"file%d",i ]];
    }
   
    [request setCompletionBlock:^{
        if ([[request responseString] isEqualToString:@"OK"]) {
            [_delegate createPostSuc:nil];
        }
        else{
            [_delegate createPostFail:request.error];
        }
        
    }];
    [request setFailedBlock:^{
        NSLog(@"error:%@",request.error);
       [_delegate createPostFail:nil];
    }];
    [request startAsynchronous];

}
-(void)createPinglunWithUserId:(NSString *)userId postId:(NSString *)postId content:(NSString *)content image:(NSData *)imageData;{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=forum&m=replyPost",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];

    
    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:postId forKey:@"postId"];
    [request setPostValue:content forKey:@"content"];
    [request setFile:imageData withFileName:@"aaa.png" andContentType:@"image/jpeg" forKey:@"file"];
    [request setCompletionBlock:^{
        NSLog(@"responseString:%@",[request responseString]);
        if ([[request responseString] isEqualToString:@"OK"]) {
            [_delegate createFaTieWithUPCSuc:nil];
        }
        else{
            [_delegate createFaTieWithUPCFail:request.error];
        }
        
    }];
    [request setFailedBlock:^{
        NSLog(@"error:%@",request.error);
        [_delegate createFaTieWithUPCFail:nil];
    }];
    [request startAsynchronous];
}
-(void)findActivitiesByPageNo:(NSString *)pageNo{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=activity&m=page&pageNo=%@",baseURL,pageNo];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSLog(@"strUrl:%@",urlStr);
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    
    [request setCompletionBlock:^{
       
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];

            [_delegate findActivitiesByPageNoSuc:dic];
      
        
    }];
    [request setFailedBlock:^{
        [_delegate findActivitiesByPageNoFail:request.error];
    }];
    [request startAsynchronous];

}
-(void)findDetailActivityByActivityId:(NSString *)activityId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=activity&m=view&activityId=%@",baseURL,activityId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    
    [request setCompletionBlock:^{
        
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:nil];
        
        [_delegate findDetailActivityByActivityIdSuc:dic];
        
        
    }];
    [request setFailedBlock:^{
        [_delegate findDetailActivityByActivityIdFail:request.error];
    }];
    [request startAsynchronous];
}
-(void)baomingActivityWithUserId:(NSString *)userId activityId:(NSString *)activityId{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=activity&m=apply&activityId=%@&userId=%@",baseURL,activityId,userId];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    
    [request setCompletionBlock:^{
        NSString *result=request.responseString;
        if ([result isEqualToString:@"OK"]) {
            [_delegate baomingActivityWithUSSuc:nil];
        }else{
            [_delegate baomingActivityWithUSFail:nil];
        }
        
        
    }];
    [request setFailedBlock:^{
        [_delegate baomingActivityWithUSFail:nil];
    }];
    [request startAsynchronous];
}
-(void)liuyanWithUserId:(NSString *)userId activityId:(NSString *)activityId content:(NSString *)content{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=activity&m=reply",baseURL];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:activityId forKey:@"activityId"];
    [request setPostValue:content forKey:@"content"];
    [request setCompletionBlock:^{
        NSString *result=request.responseString;
        if ([result isEqualToString:@"OK"]) {
            [_delegate liuyanWithUCSuc:nil];
        }else{
            [_delegate liuyanWithUCFail:nil];
        }
    }];
    [request setFailedBlock:^{
        [_delegate liuyanWithUCFail:nil];
    }];
    [request startAsynchronous];
}
#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    ZixunActionType zixunActionType=request.tag;
    switch (zixunActionType) {
        case kGetZixuns:
        {
            NSData *data=[request responseData];
           
            SBJsonParser *parser=[[SBJsonParser alloc]init];
            NSDictionary *dictionary=[parser objectWithData:data];
            parser =nil;
            NSArray *array=[dictionary objectForKey:@"posts"];
            [_delegate findZixunBypageNOSizeSortSuc:[array retain]];
        }
            break;
        case kGetZuixinZixuns:{
            NSData *data=[request responseData];
            // NSLog(@"data:%@",data);
            NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NO];
            
            [_delegate findZuixinZixunSuc:array];
        
        }
            break;
        default:
            break;
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    ZixunActionType zixunActionType=request.tag;
    switch (zixunActionType) {
        case kGetZixuns:
        {
            [_delegate findZixunBypageNOSizeSortFail:nil];
            
            NSLog(@"requestFailedL%@",request.error);
        }
            break;
            
        default:
            break;
    }
    
}

@end
