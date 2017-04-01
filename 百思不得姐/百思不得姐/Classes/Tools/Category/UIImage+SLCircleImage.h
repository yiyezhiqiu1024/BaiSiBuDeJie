//
//  UIImage+SLCircleImage.h
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SLCircleImage)

/**
 *  圆形的图标
 */
- (instancetype)sl_circleImage;

/**
 *  根据一个图标的名字返回一个圆形的图标
 *
 *  @param name 图标的名字
 *
 *  @return 圆形的图标
 */
+ (instancetype)sl_circleImageNamed:(NSString *)name;

@end
