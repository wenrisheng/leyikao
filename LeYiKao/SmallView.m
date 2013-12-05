//
//  SmallView.m
//  LeYiKao
//
//  Created by athudong on 13-10-19.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "SmallView.h"

@implementation SmallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.userInteractionEnabled=YES;
        _button=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height-20)];
        [_button setTitle:@"数据刷新中……数据刷新中数据刷新中数据刷新中数据刷新中……" forState:UIControlStateNormal];
        _button.titleLabel.numberOfLines=0;
        [[_button titleLabel]setFont:[UIFont fontWithName:@"Arial" size:10]];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [[_button titleLabel] setFont:[UIFont fontWithName:@"Arial" size:13]];
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, frame.size.height-20, frame.size.width-20,20)];
        _timeLabel.frame=CGRectMake(10, frame.size.height-20, frame.size.width-20,20);
        _timeLabel.text=@"2013-10-21";
        _timeLabel.textAlignment=NSTextAlignmentRight;
      //  _timeLabel.textColor=[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
        _timeLabel.font=[UIFont fontWithName:@"Arial" size:10];
        [_timeLabel setTextColor:[UIColor grayColor]];
        
        [self addSubview:_button];
        [self addSubview:_timeLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc{
    self.button=nil;
    self.timeLabel=nil;
    [super dealloc];
}
@end
