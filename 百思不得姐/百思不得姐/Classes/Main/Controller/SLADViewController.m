//
//  SLADViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/4/6.
//  Copyright © 2017年 SLZeng. All rights reserved.
//  广告

#import "SLADViewController.h"

@interface SLADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@end

@implementation SLADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置启动图片
    [self setupLaunchImage];
    
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

@end
