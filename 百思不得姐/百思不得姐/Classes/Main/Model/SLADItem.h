//
//  SLADItem.h
//  百思不得姐
//
//  Created by Anthony on 17/4/6.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLADItem : NSObject
// w_picurl,ori_curl:跳转到广告界面,w,h

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;
@end
