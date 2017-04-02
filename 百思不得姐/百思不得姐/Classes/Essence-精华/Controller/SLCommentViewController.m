//
//  SLCommentViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/4/1.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLCommentViewController.h"

@interface SLCommentViewController () <UITableViewDelegate>
/** 工具条底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SLCommentViewController

static NSString * const SLTopicCellId = @"topic";
static NSString * const SLCommentCellId = @"comment";

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    
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
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SLTopicCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SLCommentCellId];
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
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    if (section == 1) return 4;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SLTopicCellId];
        cell.textLabel.text = @"最顶部的帖子数据";
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SLCommentCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"评论数据 - %zd-%zd", indexPath.section, indexPath.row];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    if (section == 1) return @"最热评论";
    return @"最新评论";
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 200;
    return 44;
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
