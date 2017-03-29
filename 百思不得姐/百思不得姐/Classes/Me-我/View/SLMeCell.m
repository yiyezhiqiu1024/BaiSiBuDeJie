//
//  SLMeCell.m
//  百思不得姐
//
//  Created by Anthony on 17/3/29.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLMeCell.h"

@implementation SLMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // imageView
    self.imageView.sl_y = SLSmallMargin;
    self.imageView.sl_height = self.contentView.sl_height - 2 * SLSmallMargin;
    self.imageView.sl_width = self.imageView.sl_height;
    
    // label
    self.textLabel.sl_x = self.imageView.sl_right + SLMargin;
}

@end
