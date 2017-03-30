//
//  SLSettingViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLSettingViewController.h"
#import "SLTestViewController.h"

/// 获得缓存文件夹路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SLSettingViewController ()

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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SLTestViewController *test = [[SLTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark - 自定义方法
/**
 *  根据一个文件夹路径计算出文件夹的大小
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 文件夹的大小
 */
- (NSInteger)getFileSize:(NSString *)directoryPath
{
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        // 获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 判断隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        // 判断是否文件夹
        BOOL isDirectory;
        // 判断文件是否存在,并且判断是否是文件夹
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 获取文件属性
        // attributesOfItemAtPath:只能获取文件的大小,获取不到文件夹的大小
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        
        // 获取文件大小
        NSInteger fileSize = [attr fileSize];
        
        totalSize += fileSize;
    }
    
    return totalSize;
}

/**
 *  获取缓存文件夹的大小的字符串文字
 *
 *  @return <#return value description#>
 */
- (NSString *)sizeText
{
    
    NSInteger totalSize = [self getFileSize:CachePath];
    
    NSString *sizeText = @"清除缓存";
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
//    if (totalSize >= 1000 * 1000 * 1000) { // totalSize >= 1GB
//        sizeText = [NSString stringWithFormat:@"%.2fGB", totalSize / 1000.0 / 1000.0 / 1000.0];
//    } else if (totalSize >= 1000 * 1000) { // 1GB > totalSize >= 1MB
//        sizeText = [NSString stringWithFormat:@"%.2fMB", totalSize / 1000.0 / 1000.0];
//    } else if (totalSize >= 1000) { // 1MB > totalSize >= 1KB
//        sizeText = [NSString stringWithFormat:@"%.2fKB", totalSize / 1000.0];
//    } else { // 1KB > totalSize
//        sizeText = [NSString stringWithFormat:@"%zdB", totalSize];
//    }
    
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
    static NSString *ID = @"setting";
    
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

@end
