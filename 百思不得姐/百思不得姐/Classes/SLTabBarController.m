//
//  SLTabBarController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/23.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLTabBarController.h"
#import "SLTestViewController.h"

@interface SLTabBarController ()
/** 中间的发布按钮 */
@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation SLTabBarController

#pragma mark - 懒加载
/** 发布按钮 */
- (UIButton *)publishButton
{
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.backgroundColor = SLRandomColor;
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        _publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
        _publishButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

#pragma mark - 初始化
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
    
    // 中间用来占位的子控制器
    [self setupOneChildViewController:[[UIViewController alloc] init] title:nil image:nil selectedImage:nil];
    
    [self setupOneChildViewController:[[UIViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    

}

/**
 *  为什么要在viewWillAppear:方法中添加发布按钮?
 *  当viewWillAppear:方法被调用的时候, tabBar内部已经添加了5个UITabBarButton
 *  就可以实现一个效果 : [发布按钮]盖在其他UITabBarButton上面
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**** 增加一个发布按钮 ****/
    [self.tabBar addSubview:self.publishButton];
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

#pragma mark - 监听
/**
 *  发布按钮点击
 */
- (void)publishClick
{
    myLogFunc
}

@end
