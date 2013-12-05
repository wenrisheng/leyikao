//
//  RadioGroup.h
//  单选多选按钮RadioButton
//
//  Created by YF02 on 13-9-18.
//  Copyright (c) 2013年 WRS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioButton.h"

@protocol RadioGroupChange <NSObject>

-(void)radioGroupChange:(id)sender;

@end

@interface RadioGroup : NSObject<RadioButtonChange>
{
    NSMutableArray *children;
    NSString *text;
    id value;
    id<RadioGroupChange> delegate;
    
    int tag;
}
@property(assign,nonatomic)int tag;
@property(assign,nonatomic)id<RadioGroupChange> delegate;
@property(readonly,nonatomic)NSString *text;
@property(readonly,nonatomic)id value;
@property(retain,nonatomic)NSMutableArray *children;
-(void)addRadioButton:(RadioButton *)rb;
@end
