//
//  RadioButton.m
//  单选多选按钮RadioButton
//
//  Created by YF02 on 13-9-18.
//  Copyright (c) 2013年 WRS. All rights reserved.
//

#import "RadioButton.h"

@implementation RadioButton
@synthesize value;
@synthesize checked;
@synthesize button;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        checked=NO;
        button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.frame.size.height)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
              [self addSubview:button];
        checkImage=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_radio_on" ofType:@"png"]];
        unCheckImage=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_radio_off" ofType:@"png"]];
        
    }
    return self;
}
-(void)buttonAction:(UIButton *)button{
   // [self setChecked:!checked];
    [delegate radioButtonChange:self];
}
-(void)setChecked:(BOOL)b{
    checked=b;
    if (checked) {
        [button setBackgroundImage:checkImage forState:UIControlStateNormal];
    }else{
      [button setBackgroundImage:unCheckImage forState:UIControlStateNormal];
    }
}
-(BOOL)checked{
    return checked;
}
-(void)dealloc{
    self.value=nil;
    self.button=nil;
    checkImage=nil;
    unCheckImage=nil;;
    [super dealloc];
}


@end
