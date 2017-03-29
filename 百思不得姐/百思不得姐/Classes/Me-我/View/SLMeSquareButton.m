//
//  SLMeSquareButton.m
//  百思不得姐
//
//  Created by Anthony on 17/3/29.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLMeSquareButton.h"
#import "SLMeSquare.h"
#import <UIButton+WebCache.h>

@implementation SLMeSquareButton

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSquare:(SLMeSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.sl_y = self.sl_height * 0.15;
    self.imageView.sl_height = self.sl_height * 0.5;
    self.imageView.sl_width = self.imageView.sl_height;
    self.imageView.sl_centerX = self.sl_width * 0.5;
    
    self.titleLabel.sl_x = 0;
    self.titleLabel.sl_y = self.imageView.sl_bottom;
    self.titleLabel.sl_width = self.sl_width;
    self.titleLabel.sl_height = self.sl_height - self.titleLabel.sl_y;
}
@end
