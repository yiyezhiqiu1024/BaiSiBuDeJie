//
//  SLCommentSectionHeader.m
//  百思不得姐
//
//  Created by Anthony on 17/4/2.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLCommentSectionHeader.h"

@implementation SLCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        
//        UISwitch *s = [[UISwitch alloc] init];
//        s.xmg_x = 200;
//        [self.contentView addSubview:s];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = SLCommentSectionHeaderFont;
    
    // 设置label的x值
    self.textLabel.sl_x = SLSmallMargin;
}

@end
