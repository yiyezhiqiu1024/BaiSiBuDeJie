//
//  SLCommentViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/4/1.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLCommentViewController.h"
#import "SLRefreshHeader.h"
#import "SLRefreshFooter.h"
#import "SLTopic.h"
#import "SLComment.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "SLCommentSectionHeader.h"
#import "SLCommentCell.h"
#import "SLTopicCell.h"

@interface SLCommentViewController () <UITableViewDataSource, UITableViewDelegate>
/** 工具条底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<SLComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<SLComment *> *lastComments;

// 对象属性名不能以new开头
// @property (nonatomic, strong) NSMutableArray<SLComment *> *newComments;

/** 最热评论 */
@property (nonatomic, strong) SLComment *savedTopCmt;
@end

@implementation SLCommentViewController

static NSString * const SLCommentCellId = @"comment";
static NSString * const SLSectionHeaderlId = @"header";

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
    [self setupHeader];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

#pragma mark - 设置UI
- (void)setupBase
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLCommentCell class]) bundle:nil] forCellReuseIdentifier:SLCommentCellId];
    [self.tableView registerClass:[SLCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:SLSectionHeaderlId];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.sl_height = 200;
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.backgroundColor = SLCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = SLCommentSectionHeaderFont.lineHeight + 2;
    
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [SLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

// -[__NSArray0 objectForKeyedSubscript:]: unrecognized selector sent to instance 0x7fb738c01870
// 错误地将NSArray当做NSDictionary来使用了

- (void)setupHeader
{
    // 处理模型数据
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 添加cell到header
    SLTopicCell *cell = [SLTopicCell sl_viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [header addSubview:cell];
    
    // 设置header的高度
    header.sl_height = cell.sl_height + SLMargin * 2;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消所有请求
    [SLNetworkTools.sharedNetworkTools.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // @"1";
    
    @SLWeakObj(self)
    
    // 发送请求
    [SLNetworkTools.sharedNetworkTools requestmethodType:SLRequestTypeGET urlString:SLCommonURL parameters:params finished:^(NSDictionary *result, NSError *error) {
        
        @SLStrongObj(self)
        // 错误校验
        if (error != nil) {
            SLLog(@"请求失败 - %@", error);
            // 让[刷新控件]结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        
        // 没有任何评论数据
        if (![result isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        self.lastComments = [SLComment mj_objectArrayWithKeyValuesArray:result[@"data"]];
        self.hotestComments = [SLComment mj_objectArrayWithKeyValuesArray:result[@"hot"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
        int total = [result[@"total"] intValue];
        if (self.lastComments.count == total) { // 全部加载完毕
            // 隐藏
            self.tableView.mj_footer.hidden = YES;
        }
        
        
    }];
}

- (void)loadMoreComments
{
    // 取消所有请求
    [SLNetworkTools.sharedNetworkTools.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.lastComments.lastObject.ID;
    
    @SLWeakObj(self)
    
    
    // 发送请求
    [SLNetworkTools.sharedNetworkTools requestmethodType:SLRequestTypeGET urlString:SLCommonURL parameters:params finished:^(NSDictionary *result, NSError *error) {
        
        @SLStrongObj(self)
        
        // 错误校验
        if (error != nil) {
            SLLog(@"请求失败 - %@", error);
            // 让[刷新控件]结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        
        if (![result isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        NSArray *moreComments = [SLComment mj_objectArrayWithKeyValuesArray:result[@"data"]];
        [self.lastComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [self.tableView reloadData];
        
        int total = [result[@"total"] intValue];
        if (self.lastComments.count == total) { // 全部加载完毕
            // 提示用户:没有更多数据
            // [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
        } else { // 还没有加载完全
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 修改约束
    CGFloat keyboardY =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.lastComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 其他情况
    return self.lastComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SLCommentCellId];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.lastComments[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SLCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SLSectionHeaderlId];
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else { // 其他情况
        header.textLabel.text = @"最新评论";
    }
    
    return header;
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
