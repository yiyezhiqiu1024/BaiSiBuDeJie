//
//  SLLoginRegisterTextField.m
//  百思不得姐
//
//  Created by Anthony on 17/3/26.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLLoginRegisterTextField.h"

static NSString * const SLPlaceholderColorKey = @"placeholderLabel.textColor";

@interface SLLoginRegisterTextField()

@end

@implementation SLLoginRegisterTextField

#pragma mark - 系统回调
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    // 设置默认的占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
    
    // 成为第一响应者 : 开始编辑\弹出键盘\获得焦点
    //    [self becomeFirstResponder];
    // 不做第一响应者 : 结束编辑\退出键盘\失去焦点
    //    [self resignFirstResponder];
}

#pragma mark - 监听
/**
 *  调用时刻 : 成为第一响应者(开始编辑\弹出键盘\获得焦点)
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:SLPlaceholderColorKey];
    return [super becomeFirstResponder];
}

/**
 *  调用时刻 : 不做第一响应者(结束编辑\退出键盘\失去焦点)
 */
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
    return [super resignFirstResponder];
}

@end
