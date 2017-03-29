//
//  SLMeViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLMeViewController.h"
#import "SLSettingViewController.h"
#import "SLMeCell.h"
#import "SLMeFooterView.h"

@interface SLMeViewController ()

@end

@implementation SLMeViewController

#pragma mark - 系统回调
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTab];
}


#pragma mark - 设置UI
- (void)setupTab
{
    self.tableView.backgroundColor = SLCommonBgColor;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SLMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(SLMargin - 35, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[SLMeFooterView alloc] init];
}

- (void)setupNav
{
    // 标题
    self.navigationItem.title = @"我的";
    // 右边-设置
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    [settingButton sizeToFit];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    // 右边-月亮
    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [moonButton addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    [moonButton sizeToFit];
    UIBarButtonItem *moonItem = [[UIBarButtonItem alloc] initWithCustomView:moonButton];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

#pragma mark - 监听
/**
 *  点击设置
 */
- (void)settingClick
{
    SLLogFunc
    
    SLSettingViewController *vc = [[SLSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

/**
 *  点击月亮
 */
- (void)moonClick
{
    SLLogFunc
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"MeCell";
    // 2.从缓存池中取
    SLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[SLMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    } else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    
    
    return cell;
}

@end
