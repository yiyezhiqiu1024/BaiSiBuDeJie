//
//  UIImage+SLCircleImage.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "UIImage+SLCircleImage.h"

@implementation UIImage (SLCircleImage)

- (instancetype)sl_circleImage
{
    // 开始图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (instancetype)sl_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] sl_circleImage];
}
@end
