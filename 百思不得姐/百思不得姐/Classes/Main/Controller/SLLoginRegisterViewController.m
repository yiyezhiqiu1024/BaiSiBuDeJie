//
//  SLLoginRegisterViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/25.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLLoginRegisterViewController.h"

@interface SLLoginRegisterViewController ()
/**
 *  登录界面左边约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@end

@implementation SLLoginRegisterViewController

#pragma mark - 系统回到
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view endEditing:YES];
}

#pragma mark - 设置UI
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 监听
/**
 *  关闭当前界面
 */
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  显示登录\注册界面
 */
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant) { // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        button.selected = NO;
        //        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
    } else { // 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = - self.view.sl_width;
        button.selected = YES;
        //        [button setTitle:@"已有帐号?" forState:UIControlStateNormal];
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

@end
