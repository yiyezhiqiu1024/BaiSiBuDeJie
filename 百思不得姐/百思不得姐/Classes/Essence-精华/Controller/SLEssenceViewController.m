//
//  SLEssenceViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLEssenceViewController.h"
#import "SLTitleButton.h"

@interface SLEssenceViewController ()
/** 当前选中的标题按钮 */
@property (nonatomic, weak) SLTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@end

@implementation SLEssenceViewController

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupScrollView];
    
    [self setupTitlesView];
}

#pragma mark - 设置UI

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = SLRandomColor;
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
}

- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    titlesView.frame = CGRectMake(0, 64, self.view.sl_width, 35);
    [self.view addSubview:titlesView];
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.sl_width / count;
    CGFloat titleButtonH = titlesView.sl_height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        SLTitleButton *titleButton = [SLTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    // 按钮的选中颜色
    SLTitleButton *lastTitleButton = titlesView.subviews.lastObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [lastTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.sl_height = 1;
    indicatorView.sl_y = titlesView.sl_height - indicatorView.sl_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

- (void)setupNav
{
    self.view.backgroundColor = SLCommonBgColor;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sl_itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

#pragma mark - 监听
- (void)titleClick:(SLTitleButton *)titleButton
{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.sl_width = titleButton.titleLabel.sl_width;
        self.indicatorView.sl_centerX = titleButton.sl_centerX;
    }];
}


- (void)tagClick
{
    SLLogFunc
}

@end
