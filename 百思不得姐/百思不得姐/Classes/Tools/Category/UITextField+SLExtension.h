//
//  UITextField+SLExtension.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SLExtension)

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *sl_placeholderColor;

/**
 *  添加一个搜索框
 *
 *  @return 搜索框
 */
+ (instancetype)sl_searchBar;

@end
