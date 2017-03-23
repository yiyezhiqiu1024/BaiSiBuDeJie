//
//  SLTabBarController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/23.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTabBarController.h"

@interface SLTabBarController ()

@end

@implementation SLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**** 设置所有UITabBarItem的文字属性 ****/
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
    
    /**** 添加子控制器 ****/
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupOneChildViewController:[[UIViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //    UITableViewController *vc0 = [[UITableViewController alloc] init];
    //    vc0.view.backgroundColor = [UIColor redColor];
    //    vc0.tabBarItem.title = @"精华";
    //    vc0.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //    vc0.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    [self addChildViewController:vc0];
    
    //    UIViewController *vc1 = [[UIViewController alloc] init];
    //    vc1.view.backgroundColor = [UIColor blueColor];
    //    vc1.tabBarItem.title = @"新帖";
    //    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    //    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    //    [self addChildViewController:vc1];
    
    //    UITableViewController *vc2 = [[UITableViewController alloc] init];
    //    vc2.view.backgroundColor = [UIColor greenColor];
    //    vc2.tabBarItem.title = @"关注";
    //    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    //    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    //    [self addChildViewController:vc2];
    
    //    UIViewController *vc3 = [[UIViewController alloc] init];
    //    vc3.view.backgroundColor = [UIColor grayColor];
    //    vc3.tabBarItem.title = @"我";
    //    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    //    [self addChildViewController:vc3];
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
    vc.view.backgroundColor = [UIColor redColor];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
}

/**
 *  初始化一个子控制器
 *
 *  @param clazz         子控制器类名
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
//- (void)setupOneChildViewController:(Class)clazz title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
//{
//    UIViewController *vc = [[clazz alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    vc.tabBarItem.title = title;
//    vc.tabBarItem.image = [UIImage imageNamed:image];
//    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    [self addChildViewController:vc];
//}


@end
