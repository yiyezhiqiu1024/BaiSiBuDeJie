//
//  SLecommendTagCell.m
//  百思不得姐
//
//  Created by Anthony on 17/4/1.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLRecommendTagCell.h"
#import "SLRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface SLRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation SLRecommendTagCell

- (void)setRecommendTag:(SLRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 头像
    [self.imageListView sl_setCircleImageNamed:recommendTag.image_list placeholderImageNamed:@"defaultUserIcon"];
    
    // 名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    // 订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
}

/**
 *  重写setFrame:的作用: 监听设置cell的frame的过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
