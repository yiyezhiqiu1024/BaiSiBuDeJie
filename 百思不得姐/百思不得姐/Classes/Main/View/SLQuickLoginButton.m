//
//  SLQuickLoginButton.m
//  百思不得姐
//
//  Created by Anthony on 17/3/25.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLQuickLoginButton.h"

@implementation SLQuickLoginButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.sl_y = 0;
    self.imageView.sl_centerX = self.sl_width * 0.5;
    
    self.titleLabel.sl_x = 0;
    self.titleLabel.sl_y = self.imageView.sl_bottom;
    self.titleLabel.sl_height = self.sl_height - self.titleLabel.sl_y;
    self.titleLabel.sl_width = self.sl_width;
}


@end
