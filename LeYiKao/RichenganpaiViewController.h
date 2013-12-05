//
//  RichenganpaiViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichengDao.h"
@interface RichenganpaiViewController : UIViewController<UITextViewDelegate,RichengDaoDelegate>{
    int year;
    int month;
    int day;
    
    int selectDay;
    
    int dayNum;
    int weekDayofFirst;
    
    NSMutableArray *dayButtons;
    NSMutableArray *chineseArray;
    NSMutableArray *englishArray;
    
     UIAlertView *alertView;
    
    UIImage *gbImage;
    
    NSString *userId;
    
    NSArray *dataArray;
}
//@property(retain,nonatomic) NSString *selectDay;
@property(retain,nonatomic)RichengDao *richengDao;
@property (retain, nonatomic) IBOutlet UIImageView *rcbgImageView;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UITextView *textView;

@property (retain, nonatomic) IBOutlet UILabel *chinaLabel;
@property (retain, nonatomic) IBOutlet UILabel *englishLabel;
- (IBAction)beforeAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)backAction:(id)sender;


@end
