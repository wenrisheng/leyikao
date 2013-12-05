//
//  ZuixinZixunView.m
//  LeYiKao
//
//  Created by athudong on 13-10-19.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ZuixinZixunView.h"

@implementation ZuixinZixunView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled=YES;
        _imagesScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, UIScreenWidth-20, 100)];
        _imagesScrollView.scrollEnabled=YES;
      
        _smallView1=[[SmallView alloc]initWithFrame:CGRectMake(0, 100, frame.size.width/2, 100)];
        _smallView2=[[SmallView alloc]initWithFrame:CGRectMake( frame.size.width/2, 100, frame.size.width/2, 100)];
        _smallView3=[[SmallView alloc]initWithFrame:CGRectMake(0, 200, frame.size.width/2, 100)];

        _smallView4=[[SmallView alloc]initWithFrame:CGRectMake(frame.size.width/2, 200, frame.size.width/2, 100)];
        _smallView5=[[SmallView alloc]initWithFrame:CGRectMake( 0, 300, frame.size.width, 100)];
       
        
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, UIScreenWidth-20, 100)];
        
      //  [_imagesScrollView addSubview:_imageView];
        _imagesScrollView.contentSize=CGSizeMake(_imagesScrollView.frame.size.width, _imagesScrollView.frame.size.height);
        
        [self addSubview:_imageView];
        [self addSubview:_smallView1];
        [self addSubview:_smallView2];
        [self addSubview:_smallView3];
        [self addSubview:_smallView4];
        [self addSubview:_smallView5];
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
    _imageView=Nil;
    _imagesScrollView=nil;
    _smallView1=nil;
    _smallView2=nil;
    _smallView3=nil;
    _smallView4=nil;
    _smallView5=nil;
    [super dealloc];
}
@end
