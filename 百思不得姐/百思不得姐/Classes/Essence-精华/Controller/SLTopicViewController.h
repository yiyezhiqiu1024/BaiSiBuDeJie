//
//  SLTopicViewController.h
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLTopic.h"
@interface SLTopicViewController : UITableViewController
/** 帖子的类型 */
// @property (nonatomic, assign) SLTopicType type;

- (SLTopicType)type;

// 这个属性会生成一个type的get方法 和 _type成员变量
// @property (nonatomic, assign, readonly) SLTopicType type;
@end

/**
 父类中的某个内容, 只允许由子类来修改\提供, 不能由外界来修改\提供
 */
