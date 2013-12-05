//
//  PeixunbanPinglunCell.m
//  LeYiKao
//
//  Created by athudong on 13-11-11.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "PeixunbanPinglunCell.h"

@implementation PeixunbanPinglunCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_contentLabel release];
    [_userLabel release];
    [_timeLabel release];
    [super dealloc];
}
@end
