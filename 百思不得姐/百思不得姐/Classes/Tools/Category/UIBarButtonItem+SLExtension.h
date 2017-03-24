//
//  UIBarButtonItem+SLExtension.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SLExtension)
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
+ (instancetype)sl_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
