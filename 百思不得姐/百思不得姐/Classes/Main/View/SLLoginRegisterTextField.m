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

@interface SLLoginRegisterTextField() <UITextFieldDelegate>

@end

@implementation SLLoginRegisterTextField

- (void)awakeFromNib
{
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    // 设置占位文字颜色
   [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
    
    self.delegate = self;
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setValue:[UIColor whiteColor] forKeyPath:SLPlaceholderColorKey];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setValue:[UIColor grayColor] forKeyPath:SLPlaceholderColorKey];
}

@end
