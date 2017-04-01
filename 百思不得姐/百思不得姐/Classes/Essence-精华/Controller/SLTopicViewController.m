//
//  SLTopicViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTopicViewController.h"
#import <AFNetworking.h>
#import "SLTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "SLRefreshHeader.h"
#import "SLRefreshFooter.h"
#import "SLTopicCell.h"
#import "SLNewViewController.h"

@interface SLTopicViewController ()
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<SLTopic *> *topics;
/** 下拉刷新的提示文字 */
@property (nonatomic, weak) UILabel *label;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation SLTopicViewController

#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (SLTopicType)type {
    return 0;
}

#pragma mark - 静态属性
static NSString * const SLTopicCellId = @"topic";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.backgroundColor = SLCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLTopicCell class]) bundle:nil] forCellReuseIdentifier:SLTopicCellId];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [SLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (NSString *)aParam
{
    if (self.parentViewController.class == [SLNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

#pragma mark - 数据加载
- (void)loadNewTopics
{
    // 取消所有请求
    //    for (NSURLSessionTask *task in self.manager.tasks) {
    //        [task cancel];
    //    }
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 关闭NSURLSession + 取消所有请求
    // [self.manager invalidateSessionCancelingTasks:YES];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    @SLWeakObj(self)
    
    // 发送请求
    [self.manager GET:SLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        @SLStrongObj(self)
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topics = [SLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        @SLStrongObj(self)
        
        if (error.code == NSURLErrorCancelled) {
            // 取消了任务
        } else {
            // 是其他错误
        }
        SLLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

// 一个请求任务被取消了(cancel), 会自动调用AFN请求的failure这个block

- (void)loadMoreTopics
{
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
    @SLWeakObj(self)

    // 发送请求
    [self.manager GET:SLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        @SLStrongObj(self)
        
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<SLTopic *> *moreTopics = [SLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        @SLStrongObj(self)
        
        SLLog(@"请求失败 - %@", error);
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SLTopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark - 根据SLTopic模型数据计算出cell具体的高度, 并且返回
    return self.topics[indexPath.row].cellHeight;
}
@end
