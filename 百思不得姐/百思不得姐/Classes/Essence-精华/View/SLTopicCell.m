//
//  SLTopicCell.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTopicCell.h"
#import "SLTopic.h"
#import <UIImageView+WebCache.h>

@interface SLTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
/** 文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@end


@implementation SLTopicCell

- (IBAction)more {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(SLTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    //    NSString *str = @"";
    //    if (str.length) {
    //
    //    }
    
    
    // 没有最热评论
    // topic.top_cmt = @[];
    
    // 有最热评论
    // topic.top_cmt = @[@{}];
    
    // 最热评论 不能用if (topic.top_cmt)
    // if (topic.top_cmt.count) { // 有最热评论
    
    NSDictionary *comment = topic.top_cmt.firstObject;
    if (comment) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = comment[@"user"][@"username"]; // 用户名
        NSString *content = comment[@"content"]; // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= SLMargin;
    frame.origin.y += SLMargin;
    
    [super setFrame:frame];
}
@end
