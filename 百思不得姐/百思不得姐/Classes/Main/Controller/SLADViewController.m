//
//  SLADViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/4/6.
//  Copyright © 2017年 SLZeng. All rights reserved.
//  广告

#import "SLADViewController.h"
#import <AFNetworking.h>
#import "SLADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "SLTabBarController.h"


/*
 1.广告业务逻辑
 2.占位视图思想:有个控件不确定尺寸,但是层次结构已经确定,就可以使用占位视图思想
 3.屏幕适配.通过屏幕高度判断
 */

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface SLADViewController () <UITabBarControllerDelegate>
/**  启动图片视图 */
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
/**  广告容器视图 */
@property (weak, nonatomic) IBOutlet UIView *adContainView;
/**  广告视图 */
@property (nonatomic, weak) UIImageView *adView;
/**  广告模型数据 */
@property (nonatomic, strong) SLADItem *item;
/**  定时器 */
@property (nonatomic, weak) NSTimer *timer;
/**  跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

/** 记录上一次选中的子控制器的索引 */
@property (nonatomic, assign) NSUInteger lastSelectedIndex;
@end

@implementation SLADViewController
#pragma mark - 懒加载
- (UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.adContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
        _adView = imageView;
    }
    
    return _adView;
}

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载广告数据 => 拿到活时间 => 服务器 => 查看接口文档 1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转到广告界面,w,h) => 请求数据(AFN)
    [self loadAdData];
    
    // 创建定时器
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

#pragma mark - 设置UI
- (void)loadAdData
{
    // unacceptable content-type: text/html"  响应头
    
    // 1.创建请求会话管理者
    //    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    @SLWeakObj(self)
    
    // 3.发送请求
    [SLNetworkTools.sharedNetworkTools requestmethodType:SLRequestTypeGET urlString:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters finished:^(NSDictionary *result, NSError *error) {
        
        @SLStrongObj(self)
        
        if (error != nil) {
            SLLog(@"%@",error);
            return;
        }
        
        //        SLWriteToPlist(result, @"ad")
        // 请求数据 -> 解析数据(写成plist文件) -> 设计模型 -> 字典转模型 -> 展示数据
        // 获取字典
        NSDictionary *adDict = [result[@"ad"] lastObject];
        
        // 字典转模型
        _item = [SLADItem mj_objectWithKeyValues:adDict];
        
        // 创建UIImageView展示图片 =>
        CGFloat h = SLScreenW / _item.w * _item.h;
        self.adView.frame = CGRectMake(0, 0, SLScreenW, h);
        // 加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
        
    }];
}

// 设置启动图片
- (void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (iphone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (iphone4) { // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
}

#pragma mark - 监听
/**
 *  点击广告界面
 */
- (void)tap
{
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

/**
 *  点击跳转做的事情
 */
- (IBAction)clickJump {
    // 销毁广告界面,进入主框架界面
    SLTabBarController *rootVc = [[SLTabBarController alloc] init];
    rootVc.delegate = self;
    //    self.window.rootViewController = rootVc;
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVc;
    
    // 干掉定时器
    [_timer invalidate];
}

/**
 *  定时器改变
 */
- (void)timeChange
{
    // 倒计时
    static int i = 3;
    
    if (i == 0) {
        
        [self clickJump];
        
    }
    
    i--;
    
    // 设置跳转按钮文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%d)",i] forState:UIControlStateNormal];
}


#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == self.lastSelectedIndex) { // 重复点击了同一个TabBar按钮
        // 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:SLTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    // 记录目前选中的索引
    self.lastSelectedIndex = tabBarController.selectedIndex;
}
@end
