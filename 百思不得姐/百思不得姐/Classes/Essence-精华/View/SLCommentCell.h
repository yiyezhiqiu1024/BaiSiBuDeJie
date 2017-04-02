//
//  SLCommentCell.h
//  百思不得姐
//
//  Created by Anthony on 17/4/2.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLComment;

@interface SLCommentCell : UITableViewCell
/** 评论模型数据 */
@property (nonatomic, strong) SLComment *comment;
@end
