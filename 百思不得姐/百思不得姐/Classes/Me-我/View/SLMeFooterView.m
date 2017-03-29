//
//  SLMeFooterView.m
//  百思不得姐
//
//  Created by Anthony on 17/3/29.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLMeFooterView.h"
#import "SLMeSquare.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>

@implementation SLMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 字典数组 -> 模型数组
            NSArray *squares = [SLMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 根据模型数据创建对应的控件
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            SLLog(@"请求失败 - %@", error);
        }];
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares
{
    // 方块个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4; // 一行的最大列数
    CGFloat buttonW = self.sl_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        // i位置对应的模型数据
        SLMeSquare *square = squares[i];
        
        // 创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.sl_x = (i % maxColsCount) * buttonW;
        button.sl_y = (i / maxColsCount) * buttonH;
        button.sl_width = buttonW;
        button.sl_height = buttonH;
        
        // 设置数据
        //        button.backgroundColor = slRandomColor;
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        //        [button.imageView sd_setImageWithURL:[NSURL URLWithString:square.icon] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        //        [button setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
        //        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //            [button setImage:image forState:UIControlStateNormal];
        //        }];
    }
}

#pragma mark - 监听
- (void)buttonClick:(UIButton *)button
{
    SLLogFunc
}

@end
