//
//  SLRefreshFooter.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLRefreshFooter.h"

@implementation SLRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = SLCommonBgColor;
    [self setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];

    
//    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
        self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
//        self.automaticallyRefresh = NO;
}

@end
