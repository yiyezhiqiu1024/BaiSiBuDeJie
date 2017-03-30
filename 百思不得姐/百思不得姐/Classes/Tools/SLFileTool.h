//
//  SLFileTool.h
//  百思不得姐
//
//  Created by Anthony on 17/3/30.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFileTool : NSObject

/**
 *  根据一个文件夹路径计算出文件夹的大小
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 文件夹的大小
 */
+ (NSInteger)getFileSize:(NSString *)directoryPath;


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
