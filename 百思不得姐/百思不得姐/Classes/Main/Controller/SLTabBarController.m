//
//  SLTabBarController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/23.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTabBarController.h"
#import "SLTabBar.h"
#import "SLEssenceViewController.h"
#import "SLNewViewController.h"
#import "SLFollowViewController.h"
#import "SLMeViewController.h"
#import "SLNavigationController.h"

@interface SLTabBarController ()
@end

@implementation SLTabBarController

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    
    /**** 更换TabBar ****/
    [self setupTabBar];
}


#pragma mark - 设置UI
/**
 *  更换TabBar
 */
- (void)setupTabBar
{
    [self setValue:[[SLTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    // 新帖
    [self setupOneChildViewController:[[SLNavigationController alloc] initWithRootViewController:[[SLNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    // 精华
    [self setupOneChildViewController:[[SLNavigationController alloc] initWithRootViewController:[[SLEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    // 我
    [self setupOneChildViewController:[[SLNavigationController alloc] initWithRootViewController:[[SLMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 关注
    [self setupOneChildViewController:[[SLNavigationController alloc] initWithRootViewController:[[SLFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    
    
}

/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = SLRandomColor;
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
}



@end
