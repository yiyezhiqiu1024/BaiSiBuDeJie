//
//  SLFollowViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/24.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLFollowViewController.h"
#import "SLRecommendFollowViewController.h"
#import "SLLoginRegisterViewController.h"

@interface SLFollowViewController ()

/** 文本框 */
@property (nonatomic, weak) UITextField *textField;

@end

@implementation SLFollowViewController

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLCommonBgColor;
    
    // 标题(不建议使用self.title属性)
    self.navigationItem.title = @"我的关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sl_itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
    UITextField *textField = [[UITextField alloc] init];
    //    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    textField.frame = CGRectMake(100, 100, 150, 25);
    textField.placeholder = @"请输入手机号";
    textField.sl_placeholderColor = [UIColor orangeColor];
    [self.view addSubview:textField];
    self.textField = textField;
    
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.backgroundColor = [UIColor whiteColor];
    textField2.frame = CGRectMake(100, 200, 150, 25);
    textField2.placeholder = @"请输入手机号";
    [self.view addSubview:textField2];
}

#pragma mark - 监听
- (void)followClick
{
    SLLogFunc
    
    SLRecommendFollowViewController *test = [[SLRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

- (IBAction)loginRegister {
    self.textField.sl_placeholderColor = nil;
    
    NSLog(@"%@", self.textField.sl_placeholderColor);
    
//    SLLoginRegisterViewController *loginRegister = [[SLLoginRegisterViewController alloc] init];
//    [self presentViewController:loginRegister animated:YES completion:nil];
}


@end
