//
//  SLTopWindow.m
//  百思不得姐
//
//  Created by Anthony on 17/4/4.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTopWindow.h"

@implementation SLTopWindow

static UIWindow *window_;
+ (void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        // 窗口默认显示黑色
        window_.backgroundColor = [UIColor clearColor];
        // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
        // 窗口默认等级是UIWindowLevelNormal,等级最低,放在最下层,点击手势被拦截,无法被监听到
        window_.windowLevel = UIWindowLevelAlert;
        // 默认是隐藏的
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}

+ (void)topWindowClick
{
    // 主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 查找主窗口中的所有scrollView
    [self findScrollViewsInView:window];
}

/**
 *  查找view中的所有scrollView
 */
+ (void)findScrollViewsInView:(UIView *)view
{
    // 利用递归查找所有的子控件
    for (UIView *subview in view.subviews) {
        [self findScrollViewsInView:subview];
    }
    
    
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    // 判断是否跟window有重叠
    if (![view sl_intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    //    CGRect windowRect = [UIApplication sharedApplication].keyWindow.bounds;
    //    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    //    // 跟window不重叠
    //    if (!CGRectIntersectsRect(windowRect, viewRect)) return;
    
    // 如果是scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    
    // 修改offset
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    
    // [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
