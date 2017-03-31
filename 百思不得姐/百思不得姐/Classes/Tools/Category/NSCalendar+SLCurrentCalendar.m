//
//  NSCalendar+SLCurrentCalendar.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "NSCalendar+SLCurrentCalendar.h"

@implementation NSCalendar (SLCurrentCalendar)

+ (instancetype)sl_calendar
{
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
