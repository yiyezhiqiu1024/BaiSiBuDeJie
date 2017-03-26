//
//  SLLoginRegisterTextField.m
//  百思不得姐
//
//  Created by Anthony on 17/3/26.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLLoginRegisterTextField.h"
#import <objc/runtime.h>

static NSString * const SLPlaceholderColorKey = @"placeholderLabel.textColor";

@interface SLLoginRegisterTextField()

@end

@implementation SLLoginRegisterTextField

#pragma mark - 系统回调
- (void)awakeFromNib
{
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    // 设置占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听
- (void)beginEditing
{
    [self setValue:[UIColor whiteColor] forKeyPath:SLPlaceholderColorKey];
}

- (void)endEditing
{
    [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
}

@end
