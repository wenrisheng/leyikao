//
//  RadioButton.h
//  单选多选按钮RadioButton
//
//  Created by YF02 on 13-9-18.
//  Copyright (c) 2013年 WRS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioButtonChange <NSObject>

-(void)radioButtonChange:(id)sender;

@end

@interface RadioButton : UIView
{
    id value;
    BOOL checked;
    UIButton *button;
    id<RadioButtonChange> delegate;
    
    UIImage *checkImage;
    UIImage *unCheckImage;
}
@property(assign,nonatomic)id<RadioButtonChange> delegate;
@property(retain,nonatomic)id value;
@property(assign,nonatomic)BOOL checked;
@property(retain,nonatomic)UIButton *button;
-(void)setChecked:(BOOL)b;
-(BOOL)checked;
@end
