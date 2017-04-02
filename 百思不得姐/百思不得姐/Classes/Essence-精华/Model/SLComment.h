//
//  SLComment.h
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLUser;

@interface SLComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) SLUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end
