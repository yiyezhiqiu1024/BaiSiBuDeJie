//
//  SLRefreshHeader.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLRefreshHeader.h"

@interface SLRefreshHeader()
/** logo */
//@property (nonatomic, weak) UIImageView *logo;
@end

@implementation SLRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = SLCommonBgColor;
    [self setTitle:@"下拉" forState:MJRefreshStateIdle];
    [self setTitle:@"松开" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
    // 可以添加其他的子控件
//    [self addSubview:[[UISwitch alloc] init]];
    
//    UIImageView *logo = [[UIImageView alloc] init];
//    logo.image = [UIImage imageNamed:@"bd_logo1"];
//    [self addSubview:logo];
//    self.logo = logo;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
//    self.logo.sl_width = self.sl_width;
//    self.logo.sl_height = 50;
//    self.logo.sl_x = 0;
//    self.logo.sl_y = - 50;
}

@end
