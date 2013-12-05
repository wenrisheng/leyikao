//
//  RadioGroup.m
//  单选多选按钮RadioButton
//
//  Created by YF02 on 13-9-18.
//  Copyright (c) 2013年 WRS. All rights reserved.
//

#import "RadioGroup.h"

@implementation RadioGroup
@synthesize delegate;
@synthesize value;
@synthesize children;
@synthesize text;
-(id)init{
    self=[super init];
    if (self) {
        children=[[NSMutableArray alloc] init];
    }
return  self;
}
-(void)addRadioButton:(RadioButton *)rb{
    rb.delegate=self;
    if (rb.checked) {
        
        value=rb.value;
    }
    [children addObject:rb];
}
-(void)dealloc{
    children =nil;
    [super dealloc];
}
#pragma mark - RadioButtonChange
-(void)radioButtonChange:(id)sender{
    RadioButton *racioButton=sender;
       value=racioButton.value;
    if (!racioButton.checked) {
        for (RadioButton *rb in children) {
            if (rb.checked) {
                rb.checked=NO;
            }
        }
racioButton.checked=YES;
    }

    [delegate radioGroupChange:self];
}
@end
