//
//  SLSeeBigViewController.m
//  百思不得姐
//
//  Created by Anthony on 17/3/31.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLSeeBigViewController.h"
#import "SLTopic.h"
#import <UIImageView+WebCache.h>
#import "SVProgressHUD.h"

@interface SLSeeBigViewController () <UIScrollViewDelegate>
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation SLSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // scrollView.backgroundColor = [UIColor redColor];
    // scrollView.frame = self.view.bounds;
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    
    imageView.sl_width = scrollView.sl_width;
    imageView.sl_height = self.topic.height * imageView.sl_width / self.topic.width;
    imageView.sl_x = 0;
    
    if (imageView.sl_height >= scrollView.sl_height) { // 图片高度超过整个屏幕
        imageView.sl_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.sl_height);
    } else { // 居中显示
        imageView.sl_centerY = scrollView.sl_height * 0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.sl_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}


#pragma mark - 监听
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
