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

@end
