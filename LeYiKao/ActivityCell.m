//
//  ActivityCell.m
//  LeYiKao
//
//  Created by athudong on 13-11-14.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

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
    [_titleLabel release];
    [_baomingNumLabel release];
    [_dianjiLabel release];
    [_huifuLabel release];
    [super dealloc];
}
@end
