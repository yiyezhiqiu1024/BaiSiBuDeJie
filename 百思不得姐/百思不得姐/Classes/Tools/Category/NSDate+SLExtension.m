//
//  NSDate+SLExtension.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//  判断当前时间的分类方法的实现

#import "NSDate+SLExtension.h"
@implementation NSDate (SLExtension)

/**
 *  是否为今年
 */
- (BOOL)sl_isThisYear
{
    // 判断self这个日期是否为今年
    NSCalendar *calendar = [NSCalendar sl_calendar];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
}

//- (BOOL)sl_isThisYear
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy";
//
//    NSString *selfYear = [fmt stringFromDate:self];
//    NSString *nowYear = [fmt stringFromDate:[NSDate date]];
//
//    return [selfYear isEqualToString:nowYear];
//}

/**
 *  是否为今天
 *
 */
- (BOOL)sl_isToday
{
    // 判断self这个日期是否为今天
    NSCalendar *calendar = [NSCalendar sl_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    return selfCmps.year == nowCmps.year
    && selfCmps.month == nowCmps.month
    && selfCmps.day == nowCmps.day;
}

//- (BOOL)sl_isToday
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyyMMdd";
//
//    NSString *selfString = [fmt stringFromDate:self];
//    NSString *nowString = [fmt stringFromDate:[NSDate date]];
//
//    return [selfString isEqualToString:nowString];
//}

/**
 *  是否为昨天
 */
- (BOOL)sl_isYesterday;
{
    // 判断self这个日期是否为昨天
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar sl_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/**
 *  是否为明天
 */
- (BOOL)sl_isTomorrow
{
    // 判断self这个日期时候为明天
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar sl_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

@end
