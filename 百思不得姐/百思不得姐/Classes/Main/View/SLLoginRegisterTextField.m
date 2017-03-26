//
//  SLLoginRegisterTextField.m
//  百思不得姐
//
//  Created by Anthony on 17/3/26.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLLoginRegisterTextField.h"

@implementation SLLoginRegisterTextField

- (void)awakeFromNib
{
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    // 设置占位文字颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}

@end
