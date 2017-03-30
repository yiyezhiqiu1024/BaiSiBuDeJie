//
//  SLSettingViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLSettingViewController.h"
#import "SLTestViewController.h"
#import "SLFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

/// 获得缓存文件夹路径
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SLSettingViewController ()
/**
 *  缓存文件总大小
 */
@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation SLSettingViewController

#pragma mark - 系统回调
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLCommonBgColor;
    self.navigationItem.title = @"设置";
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
    
    // 获取文件夹尺寸
    [SLFileTool getFileSize:CachesPath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SLTestViewController *test = [[SLTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark - 自定义方法
/**
 *  获取缓存文件夹的大小的字符串文字
 */
- (NSString *)sizeText
{
    
    NSInteger totalSize = _totalSize;
    
    NSString *sizeText = @"清理缓存";
    // GB MB KB B
    if (totalSize >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%@（%.2fGB）", sizeText, totalSize / pow(10, 9)];
    } else if (totalSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%@（%.2fMB）", sizeText, totalSize / pow(10, 6)];
    } else if (totalSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%@（%.2fKB）", sizeText, totalSize / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%@（%zdB）", sizeText, totalSize];

    }
    
    return sizeText;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"SettingCell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [self sizeText];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    [SLFileTool removeDirectoryPath:CachesPath];
    _totalSize = 0;
    [self.tableView reloadData];
}

@end
