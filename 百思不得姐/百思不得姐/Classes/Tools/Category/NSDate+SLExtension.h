//
//  NSDate+SLExtension.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//  判断当前时间的分类方法的声明

#import <Foundation/Foundation.h>

@interface NSDate (SLExtension)

/**
 *  判断是否为今年
 */
- (BOOL)sl_isThisYear;

/**
 *  判断是否为昨天
 */
- (BOOL)sl_isYesterday;

/**
 *  判断是否为今天
 */
- (BOOL)sl_isToday;

/**
 *  判断是否为明天
 */
- (BOOL)sl_isTomorrow;

@end
