//
//  UITextField+SLPlaceholder.m
//  百思不得姐
//
//  Created by CoderSLZeng on 2017/12/8.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "UITextField+SLPlaceholder.h"

@implementation UITextField (SLPlaceholder)

- (void)setSl_placeholderColor:(UIColor *)sl_placeholderColor
{
    
    // 设置占位文字颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = sl_placeholderColor;
    
}

- (UIColor *)sl_placeholderColor
{
    return nil;
}

@end
