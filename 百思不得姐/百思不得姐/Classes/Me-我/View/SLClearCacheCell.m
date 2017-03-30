//
//  SLClearCacheCell.m
//  百思不得姐
//
//  Created by Anthony on 17/3/30.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLClearCacheCell.h"
#import "SLFileTool.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

/// 获得缓存文件夹路径
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SLClearCacheCell()
/**
 *  缓存文件总大小
 */
@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation SLClearCacheCell

#pragma mark - 系统回调
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置cell右边的指示器(用来说明正在处理一些事情)
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        // 设置cell默认的文字(如果设置文字之前userInteractionEnabled=NO, 那么文字会自动变成浅灰色)
        self.textLabel.text = @"清除缓存(正在计算缓存大小...)";
        
        // 禁止点击
        self.userInteractionEnabled = NO;
        
        [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
        
        // 获取文件夹尺寸
        [SLFileTool getFileSize:CachesPath completion:^(NSInteger totalSize) {
            
            _totalSize = totalSize;
            
            // 设置文字
            self.textLabel.text = [self sizeText];
            // 清空右边的指示器
            self.accessoryView = nil;
            // 显示右边的箭头
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // 添加手势监听器
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
            
            // 恢复点击事件
            self.userInteractionEnabled = YES;
            
            [SVProgressHUD dismiss];
        }];
    }
    return self;
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


/**
 *  清除缓存
 */
- (void)clearCache
{
    // 弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除指定文件夹的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [SLFileTool removeDirectoryPath:CachesPath];
            _totalSize = 0;
            
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                
                // 设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}

@end
