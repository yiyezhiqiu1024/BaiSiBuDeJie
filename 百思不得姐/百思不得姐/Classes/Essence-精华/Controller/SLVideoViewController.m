//
//  SLVideoViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/30.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLVideoViewController.h"
#import "SLRefreshHeader.h"
#import "SLRefreshFooter.h"


@interface SLVideoViewController ()

@end

@implementation SLVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SLLogFunc
    
    //    [self.tableView addPullToRefresh1WithActionHandler:^{
    //
    //    }];
    //    [self.tableView addPullToRefresh2WithActionHandler:^{
    //
    //    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        SLLogFunc
    }];
    
    self.tableView.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
        SLLogFunc
    }];

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = SLRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", [self class], indexPath.row];
    
    return cell;
}

@end
