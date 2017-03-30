//
//  SLEssenceViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLEssenceViewController.h"
#import "SLTitleButton.h"
#import "SLAllViewController.h"
#import "SLVideoViewController.h"
#import "SLVoiceViewController.h"
#import "SLPictureViewController.h"
#import "SLWordViewController.h"

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
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
}

#pragma mark - 设置UI

- (void)setupChildViewControllers
{
    SLAllViewController *all = [[SLAllViewController alloc] init];
    [self addChildViewController:all];
    
    SLVideoViewController *video = [[SLVideoViewController alloc] init];
    [self addChildViewController:video];
    
    SLVoiceViewController *voice = [[SLVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    SLPictureViewController *picture = [[SLPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    SLWordViewController *word = [[SLWordViewController alloc] init];
    [self addChildViewController:word];
}

- (void)setupScrollView
{
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = SLRandomColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // 添加所有子控制器的view到scrollView中
    NSUInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        UITableView *childVcView = (UITableView *)self.childViewControllers[i].view;
        childVcView.backgroundColor = SLRandomColor;
        childVcView.sl_x = i * childVcView.sl_width;
        childVcView.sl_y = 0;
        childVcView.sl_height = scrollView.sl_height;
        [scrollView addSubview:childVcView];
        
        // 内边距
        childVcView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
        childVcView.scrollIndicatorInsets = childVcView.contentInset;
    }
    scrollView.contentSize = CGSizeMake(count * scrollView.sl_width, 0);
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
    SLTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.sl_height = 1;
    indicatorView.sl_y = titlesView.sl_height - indicatorView.sl_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.sl_width = firstTitleButton.titleLabel.sl_width;
    indicatorView.sl_centerX = firstTitleButton.sl_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
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
