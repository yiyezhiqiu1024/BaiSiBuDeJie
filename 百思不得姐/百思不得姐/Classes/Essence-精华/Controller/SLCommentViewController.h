//
//  SLCommentViewController.h
//  百思不得姐
//
//  Created by Anthony on 17/4/1.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLTopic;

@interface SLCommentViewController : UIViewController
/** 帖子模型数据 */
@property (nonatomic, strong) SLTopic *topic;
@end
