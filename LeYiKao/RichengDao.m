//
//  RichengDao.m
//  LeYiKao
//
//  Created by athudong on 13-10-17.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "RichengDao.h"
#import "ASIHTTPRequest.h"
@implementation RichengDao
-(id)init{
    self=[super init];
    if (self) {
        _db=[[FMDatabase alloc] initWithPath:[DOCUMENT_PATH stringByAppendingPathComponent:@"leyikao.db"]];
        NSLog(@"documentPath:%@",DOCUMENT_PATH);
        BOOL flag=  [self isExistTable:@"richeng"];
        if (!flag) {
            
            [self createTable];
        }
        // [[FMDatabase alloc] initWithPath:];
        
        
    }
    return self;
}
- (BOOL) isExistTable:(NSString *)tableName
{
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %d", count);
        
        if (0 == count)
        {
            NSLog(@"/////////////不存在表格////////////////////");
            return NO;
        }
        else
        {
            NSLog(@"/////////////存在表格////////////////////");
            return YES;
        }
    }
    [_db close];
    NSLog(@"/////////////不存在表格////////////////////");
    return NO;
}
-(void)createTable{
    NSLog(@"//////////////////////创建表格//////////////////////////////");
    //    NSString *dbPath=[DOCUMENT_PATH stringByAppendingPathComponent:@"mail.db"];
    //    db=[FMDatabase databaseWithPath:dbPath];
    //建立数据库只需要如下一行即可,当该文件不存在时，fmdb会自己创建一个。如果你传入的参数是空串：@”” ，则fmdb会在临时文件目录下创建这个数据库，如果你传入的参数是 NULL，则它会建立一个在内存中的数据库。
    
    if ([_db open]) {
       BOOL flag= [_db executeUpdate:@"create table richeng(id integer primary key,year text,month text,day text,content text)"];
        if (flag) {
            NSLog(@"表格创建成功");
        }else{
            NSLog(@"表格创建失败");
        }
        [_db close];
    }else{
        NSLog(@"数据库打开失败！！！");
    }
    
    
}

-(void)save:(Richeng *)richeng{
    if ([_db open]) {
      //////
        FMResultSet *rs= [_db executeQuery:@"select * from richeng where year=? and month=? and day=?",richeng.year,richeng.month,richeng.day];
        NSString *content=nil;
        while ([rs next]) {
            content=[rs stringForColumn:@"content"];
            
            }
        if (content&&content.length>0) {
         BOOL flag=  [_db executeUpdate:@"update richeng set content=? where year=? and month=? and day=?",richeng.content,richeng.year,richeng.month,richeng.day];
            if (flag) {
                [_delegate saveSuc];

            }
            else{
                [_delegate saveFail:nil];
            }
        }else{
            BOOL flag= [_db executeUpdate:@"insert into richeng(year,month,day,content) values (?,?,?,?)",richeng.year,richeng.month,richeng.day,richeng.content];
            
            if (flag) {
                [_delegate saveSuc];
            }else{
                [_delegate saveFail:nil];
            }

        }
        /////////
        
        [_db close];
    }else{
        NSLog(@"数据库打开失败！！！");
        [_delegate saveFail:nil];
    }

}
-(void)update:(Richeng *)richeng{
    if ([_db open]) {
        
        BOOL flag= [_db executeUpdate:@"update richeng set content=? where year=? and month=? and day=?",richeng.content,richeng.year,richeng.month,richeng.day];
        NSLog(@"update result:%@",[NSNumber numberWithBool:flag]);
        [_db close];
    }else{
        NSLog(@"数据库打开失败！！！");
        [_delegate saveFail:nil];
    }

}
-(void)findRichengByYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [_db open];
    FMResultSet *rs= [_db executeQuery:@"select * from richeng where year=? and month=? and day=?",year,month,day];
    
    while ([rs next]) {
        Richeng *richeng=[[Richeng alloc] init];
        richeng.ID=[rs intForColumn:@"id"];
        richeng.year=[rs stringForColumn:@"year"];
        richeng.month=[rs stringForColumn:@"month"];
        richeng.day=[rs stringForColumn:@"day"];
        richeng.content=[rs stringForColumn:@"content"];
       
        [array addObject:richeng];
        richeng=nil;
    }
    [_db close];
    NSLog(@"dao array:%@",array);
    [_delegate findRichengByYMDSuc:array];
    array=nil;

}
-(NSMutableArray *)findRichengDaysByYear:(NSString *)year month:(NSString *)month{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [_db open];
    FMResultSet *rs= [_db executeQuery:@"select * from richeng where year=? and month=?",year,month];
    
    while ([rs next]) {
        Richeng *richeng=[[Richeng alloc] init];
        richeng.ID=[rs intForColumn:@"id"];
        richeng.year=[rs stringForColumn:@"year"];
        richeng.month=[rs stringForColumn:@"month"];
        richeng.day=[rs stringForColumn:@"day"];
        richeng.content=[rs stringForColumn:@"content"];
        
        [array addObject:richeng];
        richeng=nil;
    }
    [_db close];
    return [array autorelease];
    
}
-(void)dealloc{
    _db=nil;
    [super dealloc];
}
////////////////////保存到服务器
-(void)saveRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day content:(NSString *)content{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=schedule&m=Schedule_Check&check=0&telephone=%@&event=%@&date=%@",baseURL,@"12345678910",content,[self getFormatDateByYear:year month:month day:day]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        [_delegate saveRichengByUYMDCSuc:nil];
    }];
    [request setFailedBlock:^{
        [_delegate saveRichengByUYMDCFail:nil];
    }];
    [request startAsynchronous];
}
-(void)updateRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day content:(NSString *)content{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=schedule&m=Schedule_Check&check=2&telephone=%@&event=%@&date=%@",baseURL,@"12345678910",content,[self getFormatDateByYear:year month:month day:day]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        [_delegate updateRichengByUYMDCSuc:nil];
    }];
    [request setFailedBlock:^{
        [_delegate updateRichengByUYMDCFail:nil];
    }];
    [request startAsynchronous];
}
-(void)deleteRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=schedule&m=Schedule_Check&check=1&telephone=%@&date=%@",baseURL,@"12345678910",[self getFormatDateByYear:year month:month day:day]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        [_delegate deleteRichengByUYMDCSuc:nil];
    }];
    [request setFailedBlock:^{
        [_delegate deleteRichengByUYMDCFail:nil];
    }];
    [request startAsynchronous];
}
-(void)findRichengByUserId:(NSString *)userId year:(NSString *)year month:(NSString *)month{
    NSString *urlStr=[NSString stringWithFormat:@"%@?c=schedule&m=GetSchedule_DayAndEvent&telephone=%@&year=%@&month=%@",baseURL,@"12345678910",year,month];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        NSArray *array=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:Nil];
        [_delegate findRichengByUYMSuc:array];
    }];
    [request setFailedBlock:^{
        [_delegate findRichengByUYMFail:request.error];
    }];
    [request startAsynchronous];
}
-(NSString *)getFormatDateByYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *date=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    return date;
}
@end
