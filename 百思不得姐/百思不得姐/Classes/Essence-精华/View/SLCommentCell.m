//
//  SLCommentCell.m
//  百思不得姐
//
//  Created by Anthony on 17/4/2.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLCommentCell.h"
#import "SLComment.h"
#import "SLUser.h"

@interface SLCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation SLCommentCell

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setComment:(SLComment *)comment
{
    _comment = comment;
    
//    if (arc4random_uniform(100) > 50) {
//        comment.voicetime = arc4random_uniform(60);
//        comment.voiceuri = @"http://123.mp3";
//        comment.content = nil;
//    }
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    [self.profileImageView  sl_setCircleImageNamed:comment.user.profile_image placeholderImageNamed:@"defaultUserIcon"];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:SLUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image =  [UIImage imageNamed:sexImageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

@end
