//
//  SLSettingViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLSettingViewController.h"
#import "SLTestViewController.h"

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
- (NSInteger)getCacheSize
{
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    // 获取default文件路径
    NSString *defaultPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default/7f4cfb7adaed77b1bfae07698a016ce0.png"];
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件属性
    // attributesOfItemAtPath:只能获取文件的大小,获取不到文件夹的大小
    NSDictionary *attr = [mgr attributesOfItemAtPath:defaultPath error:nil];
    
    // default尺寸
    NSInteger fileSize = [attr fileSize];
    
    return fileSize;
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
    
    NSString *text = [NSString stringWithFormat:@"清除缓存(%zdB)", [self getCacheSize]];
    cell.textLabel.text = text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
