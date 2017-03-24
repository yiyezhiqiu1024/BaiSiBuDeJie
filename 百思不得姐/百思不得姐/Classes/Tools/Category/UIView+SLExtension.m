//
//  UIView+SLExtension.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "UIView+SLExtension.h"

@implementation UIView (SLExtension)

/**** x, y, width, height 的setter和getter方法 ****/
- (void)setSl_x:(CGFloat)sl_x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = sl_x;
    self.frame = newFrame;
}

- (CGFloat)sl_x
{
    return self.frame.origin.x;
}

- (void)setSl_y:(CGFloat)sl_y
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = sl_y;
    self.frame = newFrame;
}

- (CGFloat)sl_y
{
    return self.frame.origin.y;
}


- (void)setSl_width:(CGFloat)sl_width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = sl_width;
    self.frame = newFrame;
}

- (CGFloat)sl_width
{
    return self.frame.size.width;
}

- (void)setSl_height:(CGFloat)sl_height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = sl_height;
    self.frame = newFrame;
}

- (CGFloat)sl_height
{
    return self.frame.size.height;
}

/**** top, bottom, left, right 的setter和getter方法 ****/
- (void)setSl_top:(CGFloat)sl_top
{
    sl_top = self.sl_y;
}

- (CGFloat)sl_top
{
    return self.sl_y;
}

- (void)setSl_bottom:(CGFloat)sl_bottom
{
//    sl_bottom = CGRectGetMaxY(self.frame);
    self.sl_y = sl_bottom - self.sl_height;
}

- (CGFloat)sl_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setSl_left:(CGFloat)sl_left
{
    sl_left = self.sl_x;
}

- (CGFloat)sl_left
{
    return self.sl_x;
}

- (void)setSl_right:(CGFloat)sl_right
{
//    sl_right = CGRectGetMaxX(self.frame);
    self.sl_x = sl_right - self.sl_width;
}


- (CGFloat)sl_right
{
    return CGRectGetMaxX(self.frame);
}

/**** orgin, size, centerX, centerY 的setter和getter方法 ****/
- (void)setSl_orgin:(CGPoint)sl_orgin
{
    CGRect newFrame = self.frame;
    newFrame.origin = sl_orgin;
    self.frame = newFrame;
}

- (CGPoint)sl_orgin
{
    return self.frame.origin;
}

- (void)setSl_size:(CGSize)sl_size
{
    CGRect newFrame = self.frame;
    newFrame.size = sl_size;
    self.frame = newFrame;
}

- (CGSize)sl_size
{
    return self.frame.size;
}

- (void)setSl_centerX:(CGFloat)sl_centerX
{
    CGPoint newCenter =  self.center;
    newCenter.x = sl_centerX;
    self.center = newCenter;
}

- (CGFloat)sl_centerX
{
    return self.center.x;
}

- (void)setSl_centerY:(CGFloat)sl_centerY
{
    CGPoint newCenter = self.center;
    newCenter.y = sl_centerY;
    self.center = newCenter;
}

- (CGFloat)sl_centerY
{
    return self.center.y;
}

#pragma mark - 加载Xib
+ (instancetype)sl_viewFromXib
{
    return  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


- (BOOL)sl_intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(selfRect, viewRect);
}
@end
