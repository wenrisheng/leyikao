//
//  YikaoCommunityCell.m
//  LeYiKao
//
//  Created by athudong on 13-10-16.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "YikaoCommunityCell.h"

@implementation YikaoCommunityCell

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
    [_label release];
    [_writerLabel release];
    [_dianjiLabel release];
    [_huifuLabel release];
    [super dealloc];
}
@end
