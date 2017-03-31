//
//  SLExtensionConfig.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLExtensionConfig.h"
#import <MJExtension.h>
#import "SLTopic.h"
#import "SLComment.h"

@implementation SLExtensionConfig

+ (void)load
{
    [SLTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [SLComment class]};
    }];
    
    [SLTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
}
@end