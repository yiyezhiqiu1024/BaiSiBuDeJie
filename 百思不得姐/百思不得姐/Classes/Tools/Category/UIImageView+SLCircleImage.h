//
//  UIImageView+SLCircleImage.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SLCircleImage)

/**
 *  设置圆形图标
 *
 *  @param urlStr    图标的URL字符串
 *  @param imageName 占位图标名字
 */
- (void)sl_setCircleImageNamed:(NSString *)urlStr  placeholderImageNamed:(NSString *)imageName;

/**
 *  设置矩形的图标
 *
 *  @param urlStr    图标的URL字符串
 *  @param imageName 占位图标名字
 */
- (void)sl_setRectImageNamed:(NSString *)urlStr  placeholderImageNamed:(NSString *)imageName;

@end
