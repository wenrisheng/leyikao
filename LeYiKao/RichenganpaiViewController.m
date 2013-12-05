//
//  RichenganpaiViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "RichenganpaiViewController.h"
#import "UIAlertView+customShow.h"
@interface RichenganpaiViewController ()

@end

@implementation RichenganpaiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        chineseArray=[[NSMutableArray alloc] init];
               for (int i=0; i<12; i++) {
            NSString *str=[NSString stringWithFormat:@"%d月",i+1];
            [chineseArray addObject:str];
        }
        englishArray=[[NSMutableArray alloc] init];
        [englishArray addObject:@"JAN"];
        [englishArray addObject:@"FEB"];
        [englishArray addObject:@"MAR"];
        [englishArray addObject:@"APR"];
        [englishArray addObject:@"MAY"];
        [englishArray addObject:@"JUN"];
        [englishArray addObject:@"JUL"];
        [englishArray addObject:@"AUG"];
        [englishArray addObject:@"SEP"];
        [englishArray addObject:@"OCT"];
        [englishArray addObject:@"NOV"];
        [englishArray addObject:@"DEC"];
        
        //当前年月日
         NSDate *date=[NSDate date];
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYY-MM-dd"];
      NSString *dateStr=[df stringFromDate:date];
        NSArray *dateArray=[dateStr componentsSeparatedByString:@"-"];
        year=[[dateArray objectAtIndex:0] integerValue];
        month=[[dateArray objectAtIndex:1] integerValue];
        day=[[dateArray objectAtIndex:2] integerValue];
        df=nil;
        
        
        // 当前月的天数
        NSCalendar *calendar=[NSCalendar currentCalendar];
        NSRange dayRange= [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
        dayNum=dayRange.length;
      
       

        //当前月第一天是星期几，星期日为7
        NSDateComponents *weekdayComponents =
        
        [calendar components:NSWeekdayCalendarUnit fromDate:date];
        
       weekDayofFirst = [weekdayComponents weekday];
        
        dayButtons=[[NSMutableArray alloc] init];
        
        //richengdao
        _richengDao=[[RichengDao alloc] init];
        _richengDao.delegate=self;
        
         alertView=[[UIAlertView alloc] init];
        gbImage=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"yuan-01" ofType:@"png"]];
        
         userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [_richengDao findRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
    
    
      self.navigationController.navigationBarHidden=YES;
    NSString *dateStr=[NSString stringWithFormat:@"%d/%d/%d",year,month,day];
    _dateLabel.text=[dateStr substringFromIndex:2];
    
    NSMutableArray *array=[_richengDao findRichengDaysByYear:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
    
        //初始化日期按钮
    
  
    for (int i=0; i<42; i++) {
        int x=20+i%7*40;
        int y=i/7*40+210;
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(x, y, 30, 30)];
       [button addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=0;
        button.enabled=NO;
               [dayButtons addObject:button];
        [self.view addSubview:button];
        button=nil;
       
    }
    for (int i=0; i<dayNum; i++) {
        int start=i+weekDayofFirst-1;
        UIButton *button=[dayButtons objectAtIndex:start];
        button.enabled=YES;
            [button setTitleColor:[UIColor colorWithRed:0.42 green:0.43 blue:0.43 alpha:1] forState:UIControlStateNormal];
        button.tag=i+1;
       
//        for (Richeng *rc in array) {
//            int d=[[rc day] intValue];
//            int m=[[rc month] intValue];
//            int y=[[rc year]intValue];
//            if (button.tag==d&&month==m&&year==y) {
//                [button setBackgroundImage:gbImage forState:UIControlStateNormal];
//            }
//        }
        
        if (day==i+1) {
            selectDay=day;
            [button setTitleColor:[UIColor colorWithRed:0.94 green:0.29 blue:0.15 alpha:1] forState:UIControlStateNormal];
        }
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
    }
    
    
    _chinaLabel.text=[chineseArray objectAtIndex:month-1];
    _englishLabel.text=[englishArray objectAtIndex:month-1];
    
 //[_richengDao findRichengByYear:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month] day:[NSString stringWithFormat:@"%d",selectDay]];
}
-(void)dayButtonAction:(UIButton *)button{
    _rcbgImageView.frame=CGRectMake(button.frame.origin.x, button.frame.origin.y,_rcbgImageView.frame.size.width, _rcbgImageView.frame.size.height);
    int tag=button.tag;
    selectDay=tag;
    NSLog(@"dataArray:%@",dataArray);
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K==%@",[NSString stringWithFormat:@"%@",@"day(date)"],[NSString stringWithFormat:@"%d",tag]];
    NSArray *array=[dataArray filteredArrayUsingPredicate:predicate];
    if (array&&array.count>0) {
        NSDictionary *dic=[array objectAtIndex:0];
        _textView.text=[dic objectForKey:@"event"];
    }
    else{
        _textView.text=nil;
    }
    // [_richengDao findRichengByYear:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month] day:[NSString stringWithFormat:@"%d",selectDay]];
    NSLog(@"buton tag:%d",tag);
}
-(void)refreshCalendar{
    
     NSMutableArray *array=[_richengDao findRichengDaysByYear:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
    for (UIButton *button  in dayButtons) {
        [button setTitle:nil forState:UIControlStateNormal];
        button.tag=0;
        button.enabled=NO;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYY-MM-dd"];
    NSDate *date=[df dateFromString:[NSString stringWithFormat:@"%d-%d-%d",year,month,01]];
    // 当前月的天数
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSRange dayRange= [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    dayNum=dayRange.length;
   
    
    
    //当前月第一天是星期几，星期日为7
    NSDateComponents *weekdayComponents =
    
    [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    weekDayofFirst = [weekdayComponents weekday];
    
    
    for (int i=0; i<dayNum; i++) {
        int start=i+weekDayofFirst-1;
        UIButton *button=[dayButtons objectAtIndex:start];
        [button setTitleColor:[UIColor colorWithRed:0.42 green:0.43 blue:0.43 alpha:1] forState:UIControlStateNormal];
        button.tag=i+1;
        button.enabled=YES;
       
        if (day==i+1) {
            [button setTitleColor:[UIColor colorWithRed:0.94 green:0.29 blue:0.15 alpha:1] forState:UIControlStateNormal];
        }
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
      
    }
    
    
    _chinaLabel.text=[chineseArray objectAtIndex:month-1];
    _englishLabel.text=[englishArray objectAtIndex:month-1];
     [_richengDao findRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
    
    
      }
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    dataArray=nil;
    userId=nil;
    gbImage=nil;
    _richengDao=nil;
    chineseArray=nil;
    englishArray=nil;
    dayButtons=nil;
    [_dateLabel release];
    [_chinaLabel release];
    [_englishLabel release];
    [_textView release];
    [_rcbgImageView release];
    [super dealloc];
}
- (IBAction)beforeAction:(id)sender {
    _textView.text=nil;
    if (month!=1) {
        month-=1;
    }else{
        month=12;
        year-=1;
    }
    [self refreshCalendar];
    
   
}

- (IBAction)nextAction:(id)sender {
   _textView.text=nil;
    if (month!=12) {
        month+=1;
    }else{
        month=1;
        year+=1;
    }
    [self refreshCalendar];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UItextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{


    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K==%@",[NSString stringWithFormat:@"%@",@"day(date)"],[NSString stringWithFormat:@"%d",selectDay]];
    NSArray *array=[dataArray filteredArrayUsingPredicate:predicate];
    if (array&&array.count>0) {
        [_richengDao updateRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month] day:[NSString stringWithFormat:@"%d",selectDay] content:_textView.text];
    }
        else{
        [self performSelectorInBackground:@selector(saveRicheng) withObject:nil];
    }

    
   
 //   [self performSelector:@selector(saveRicheng) withObject:nil];
    
}
-(void)saveRicheng{
    [_richengDao saveRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month] day:[NSString stringWithFormat:@"%d",selectDay] content:_textView.text];
    
//    Richeng *richeng=[[Richeng alloc] init];
//    richeng.year=[NSString stringWithFormat:@"%d",year];
//    richeng.month=[NSString stringWithFormat:@"%d",month];
//    richeng.content=_textView.text;
//    //NSLog(@"selectDay:%@",_selectDay);
//    richeng.day=[NSString stringWithFormat:@"%d",selectDay];;
//    [_richengDao save:richeng];
//    richeng=nil;
}
#pragma mark - richengDelegate
-(void)saveSuc{
    [self refreshCalendar];
    [self performSelectorOnMainThread:@selector(showSucMessage) withObject:nil waitUntilDone:NO];
}
-(void)showSucMessage{
     [self showAlertViewWithMessage:@"保存成功" time:1];
}
-(void)saveFail:(NSError *)error{
     [self showAlertViewWithMessage:@"保存失败" time:1];
}
-(void)findRichengByYMDSuc:(NSMutableArray *)array{
    if (array&&array.count>0) {
        Richeng *richeng=[array objectAtIndex:0];
        _textView.text=richeng.content;
      //  [self performSelectorOnMainThread:@selector(refreshTextView:) withObject:richeng.content waitUntilDone:NO];
       
        NSLog(@"richeng content:%@",richeng.content);
    }else{
        _textView.text=nil;
    }
}
-(void)showAlertViewWithMessage:(NSString *)message time:(float)time{
    alertView.message=message;
    [alertView show];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(dismissAlertView:) userInfo:alertView repeats:NO];
}
-(void)dismissAlertView:(NSTimer *)timer{
    [(UIAlertView*) timer.userInfo  dismissWithClickedButtonIndex:0 animated:YES];
    
}
#pragma mark - richengdaoDelegate
-(void)findRichengByUYMSuc:(id)value{
    
    
     dataArray=[value retain];
    for (NSDictionary *dic in dataArray) {
        int d=[[dic objectForKey:@"day(date)"] intValue];
        for (UIButton *button in dayButtons) {
            if (button.tag==d) {
                 [button setBackgroundImage:gbImage forState:UIControlStateNormal];
            }
        }
        if (d==selectDay) {
            _textView.text=[dic objectForKey:@"event"];
        }
       
    }
}
-(void)findRichengByUYMFail:(NSError *)error{
    [UIAlertView showWithTitle:nil message:@"查找日程错误" time:2];
}
-(void)saveRichengByUYMDCSuc:(id)value{
     [self showAlertViewWithMessage:@"保存成功" time:1];
       [_richengDao findRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
}
-(void)saveRichengByUYMDCFail:(NSError *)error{
     [self showAlertViewWithMessage:@"保存失败" time:1];
}
-(void)updateRichengByUYMDCSuc:(id)value{
    [self showAlertViewWithMessage:@"更新成功" time:1];
    [_richengDao findRichengByUserId:userId year:[NSString stringWithFormat:@"%d",year] month:[NSString stringWithFormat:@"%d",month]];
}
-(void)updateRichengByUYMDCFail:(NSError *)error{
     [self showAlertViewWithMessage:@"更新失败" time:1];
}
@end
