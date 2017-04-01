//
//  SLRecommendTagViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/4/1.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLRecommendTagViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "SLRecommendTag.h"
#import "SLRecommendTagCell.h"
#import <SVProgressHUD.h>

@interface SLRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是SLRecommendTag模型) */
@property (nonatomic, strong) NSArray<SLRecommendTag *> *recommendTags;

/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation SLRecommendTagViewController

/** manager属性的懒加载 */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString * const SLRecommendTagCellId = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SLRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = SLCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 加载标签数据
    [self loadNewRecommandTags];
}

/**
 *  加载标签数据
 */
- (void)loadNewRecommandTags
{
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    @SLWeakObj(self)
    
    // 发送请求
    [self.manager GET:SLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        @SLStrongObj(self)
        // 字典数组 -> 模型数组
        self.recommendTags = [SLRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新
        [self.tableView reloadData];
        
        // 去除HUD
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
    }];
}

/**
 *  当控制器的view即将消失的时候调用
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 隐藏HUD
    [SVProgressHUD dismiss];
    
    // 取消请求
    // [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SLRecommendTagCellId];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}

@end
