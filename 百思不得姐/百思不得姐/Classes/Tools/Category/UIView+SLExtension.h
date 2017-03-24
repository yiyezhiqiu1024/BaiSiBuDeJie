//
//  UIView+SLExtension.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//  view的尺寸设置分类的声明

#import <UIKit/UIKit.h>

@interface UIView (SLExtension)
/** x值 */
@property (nonatomic, assign) CGFloat sl_x;
/** y值 */
@property (nonatomic, assign) CGFloat sl_y;
/** 宽度值 */
@property (nonatomic, assign) CGFloat sl_width;
/** 高度值 */
@property (nonatomic, assign) CGFloat sl_height;

/** 顶部的值 */
@property (nonatomic, assign) CGFloat sl_top;
/** 底部的值 */
@property (nonatomic, assign) CGFloat sl_bottom;
/** 左边的值 */
@property (nonatomic, assign) CGFloat sl_left;
/** 右边的值 */
@property (nonatomic, assign) CGFloat sl_right;

/** 原点的值 */
@property (nonatomic, assign) CGPoint sl_orgin;
/** size的值 */
@property (nonatomic, assign) CGSize sl_size;

/** 中心点x值 */
@property (nonatomic, assign) CGFloat sl_centerX;
/** 中心点y值 */
@property (nonatomic, assign) CGFloat sl_centerY;

#pragma mark - 加载Xib
+ (instancetype)sl_viewFromXib;

/** 判断两个view是否相交 */
- (BOOL)sl_intersectWithView:(UIView *)view;
@end
