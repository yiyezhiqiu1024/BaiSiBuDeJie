//
//  UIImageView+SLCircleImage.m
//  <#项目名称#>
//
//  Created by SLZeng on 16/8/16.
//  Copyright © 2016年 Zeng. All rights reserved.
//

#import "UIImageView+SLCircleImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (SLCircleImage)

- (void)sl_setCircleImageNamed:(NSString *)urlStr placeholderImageNamed:(NSString *)imageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage sl_circleImageNamed:imageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = [image sl_circleImage];
    }];
}

- (void)sl_setRectImageNamed:(NSString *)urlStr placeholderImageNamed:(NSString *)imageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName]];
}
@end
