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

@interface SLCommentViewController () <UITableViewDataSource, UITableViewDelegate>
/** 工具条底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<SLComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<SLComment *> *lastComments;

// 对象属性名不能以new开头
// @property (nonatomic, strong) NSMutableArray<SLComment *> *newComments;
@end

@implementation SLCommentViewController

static NSString * const SLCommentCellId = @"comment";
static NSString * const SLSectionHeaderlId = @"header";

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
    
    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // @"1";
    
    @SLWeakObj(self)
    
    // 发送请求
    [self.manager GET:SLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        @SLStrongObj(self)
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        self.lastComments = [SLComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotestComments = [SLComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @SLStrongObj(self)
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //    if (弹出) {
    //        self.bottomMargin.constant = 键盘高度;
    //    } else {
    //        self.bottomMargin.constant = 0;
    //    }
    
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
    //    if (self.lastestComments.count && self.hotestComments.count) return 2;
    //    if (self.lastestComments.count && self.hotestComments.count == 0) return 1;
    //
    //    return 0;
    
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.lastComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    // 第0组
    //    if (section == 0) {
    //        if (self.hotestComments.count) {
    //            return self.hotestComments.count;
    //        } else {
    //            return self.lastestComments.count;
    //        }
    //    }
    //
    //    // 其他组 - section == 1
    //    return self.lastestComments.count;
    
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        return @"最热评论";
//    }
//
//    // 其他情况
//    return @"最新评论";
//}

#pragma mark - 代理方法
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = tableView.backgroundColor;
//    label.font = SLCommentSectionHeaderFont;
//    label.textColor = [UIColor darkGrayColor];
//
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        label.text = @"最热评论";
//    } else { // 其他情况
//        label.text = @"最新评论";
//    }
//
//    return label;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIButton *button = [[UIButton alloc] init];
//    button.backgroundColor = tableView.backgroundColor;
//
//    // 内边距
//    button.contentEdgeInsets = UIEdgeInsetsMake(0, SLMargin, 0, 0);
//    // button.titleEdgeInsets = UIEdgeInsetsMake(0, SLMargin, 0, 0);
//    // 让按钮内部的内容, 在按钮中左对齐
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//
//    button.titleLabel.font = SLCommentSectionHeaderFont;
//
//    // 让label的文字在label内部左对齐
//    // button.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        [button setTitle:@"最热评论" forState:UIControlStateNormal];
//    } else { // 其他情况
//        [button setTitle:@"最新评论" forState:UIControlStateNormal];
//    }
//
//    return button;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //    if (header == nil) {
//    //        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:SLSectionHeaderlId];
//    //        header.textLabel.textColor = [UIColor darkGrayColor];
//    //    }
//
//
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SLSectionHeaderlId];
//
//    header.textLabel.textColor = [UIColor darkGrayColor];
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        header.textLabel.text = @"最热评论";
//    } else { // 其他情况
//        header.textLabel.text = @"最新评论";
//    }
//
//    return header;
//}

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
