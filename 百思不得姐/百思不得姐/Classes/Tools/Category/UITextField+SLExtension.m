//
//  UITextField+SLExtension.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "UITextField+SLExtension.h"

static NSString * const SLPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (SLExtension)

- (void)setSl_placeholderColor:(UIColor *)sl_placeholderColor
{
    NSString *oldPlacehoder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlacehoder;
    
    if (sl_placeholderColor == nil) {
        sl_placeholderColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0.0980392/255.0 alpha:0.22/255.0];
    }
    
    [self setValue:sl_placeholderColor forKeyPath:SLPlaceholderColorKey];
}

- (UIColor *)sl_placeholderColor
{
    return [self valueForKeyPath:SLPlaceholderColorKey];
}


/**
 *  添加一个搜索框
 *
 *  @return 搜索框
 */
+ (instancetype)sl_searchBar
{
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.bounds = CGRectMake(0, 0, 300, 30);
    searchBar.font = [UIFont systemFontOfSize:13.0];
    searchBar.placeholder = @"请输入搜索内容条件";
    
    UIImage *searchBarImage = [UIImage imageNamed:@"searchbar_textfield_background"];
    
    CGFloat searchBarW = searchBarImage.size.width * 0.5;
    CGFloat searchBarH = searchBarImage.size.height * 0.5;
    
    // 设置背景图片为可拉伸模式的
    searchBar.background = [searchBarImage resizableImageWithCapInsets:UIEdgeInsetsMake(searchBarH, searchBarW, searchBarH, searchBarW) resizingMode:UIImageResizingModeStretch];
    
    
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.bounds = CGRectMake(0, 0, 30, 30);
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];

    // 内容模式居中
    searchIcon.contentMode = UIViewContentModeCenter;
    
    // 左边的视图
    searchBar.leftView = searchIcon;
    // 显示模式
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    return searchBar;
}

@end
