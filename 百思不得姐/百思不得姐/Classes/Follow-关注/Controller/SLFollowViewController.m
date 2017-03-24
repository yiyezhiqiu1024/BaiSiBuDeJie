//
//  SLFollowViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLFollowViewController.h"
#import "SLRecommendFollowViewController.h"


@interface SLFollowViewController ()

@end

@implementation SLFollowViewController

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLCommonBgColor;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sl_itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

#pragma mark - 监听
- (void)followClick
{
    SLLogFunc
    
    SLRecommendFollowViewController *test = [[SLRecommendFollowViewController alloc] init];
    test.view.backgroundColor = SLRandomColor;
    test.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test animated:YES];
}


@end
