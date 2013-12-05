//
//  CollectCell.m
//  LeYiKao
//
//  Created by athudong on 13-10-25.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "CollectCell.h"

@implementation CollectCell

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

    [_modelLabel release];
    [_contentLabel release];
    [_timeLabel release];
    [super dealloc];
}
@end
