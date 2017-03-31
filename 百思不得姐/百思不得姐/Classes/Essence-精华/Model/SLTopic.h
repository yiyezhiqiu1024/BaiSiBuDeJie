//
//  SLTopic.h
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SLTopicType) {
    /** 图片 */
    SLTopicTypePicture = 10,
    /** 段子 */
    SLTopicTypeWord = 29,
    /** 声音 */
    SLTopicTypeVoice = 31,
    /** 视频 */
    SLTopicTypeVideo = 41
};


@class SLComment;

@interface SLTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 最热评论 */
@property (nonatomic, strong) SLComment *top_cmt;

/** 帖子类型 */
@property (nonatomic, assign) SLTopicType type;

/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;


/***** 额外增加的属性 - 方便开发 *****/
@property (nonatomic, assign) CGFloat cellHeight;
@end
