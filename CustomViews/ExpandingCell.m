//
//  ExpandingCell.m
//  CustomViews
//
//  Created by TouchROI on 2/27/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "ExpandingCell.h"

@implementation ExpandingCell

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

@end
