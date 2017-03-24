//
//  UIBarButtonItem+SLExtension.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "UIBarButtonItem+SLExtension.h"

@implementation UIBarButtonItem (SLExtension)

/**
 *  自定义UIBarButtonItem
 *
 *  @param image     图标
 *  @param highImage 高亮图标
 *  @param target    监听对象
 *  @param action    监听方法
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)sl_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
