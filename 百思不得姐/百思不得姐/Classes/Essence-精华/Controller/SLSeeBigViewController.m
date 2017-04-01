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

// #import <AssetsLibrary/AssetsLibrary.h> // iOS9开始废弃
#import <Photos/Photos.h> // iOS9开始推荐

#import <SVProgressHUD.h>

@interface SLSeeBigViewController () <UIScrollViewDelegate>
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation SLSeeBigViewController

static NSString * SLAssetCollectionTitle = @"百思不得姐";

#pragma mark - 系统回调
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
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        SLLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            SLLog(@"保存[图片]到[相机胶卷]失败!失败信息-%@", error);
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 2.创建"相簿"
            // 创建相簿的请求
            assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:SLAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                SLLog(@"创建相簿失败!失败信息-%@", error);
                return;
            }
            
            // 获得曾经创建过的相簿
            PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
            if (createdAssetCollection) { // 曾经创建过相簿
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    // 3.添加"相机胶卷"中的图片A到"相簿"D中
                    
                    // 获得图片
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                    
                    // 添加图片到相簿中的请求
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                    
                    // 添加图片到相簿
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success == NO) {
                        SLLog(@"失败信息-%@", error);
                        [SVProgressHUD showErrorWithStatus:@"保存[图片]到[相簿]失败"];
                    } else {
                        [SVProgressHUD showSuccessWithStatus:@"成功保存[图片]到[相簿]"];
                    }
                }];
            } else { // 没有创建过相簿
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    // 3.添加"相机胶卷"中的图片A到新建的"相簿"D中
                    
                    // 获得相簿
                    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
                    
                    // 获得图片
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                    
                    // 添加图片到相簿中的请求
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    
                    // 添加图片到相簿
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success == NO) {
                        SLLog(@"失败信息-%@", error);
                        [SVProgressHUD showErrorWithStatus:@"保存[图片]到[相簿]失败"];
                    } else {
                        [SVProgressHUD showSuccessWithStatus:@"成功保存[图片]到[相簿]"];
                    }
                }];
            }
            
        }];
        
    }];

}

/**
 *  获得曾经创建过的相簿
 */
- (PHAssetCollection *)createdAssetCollection
{
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:SLAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    return nil;
}

#pragma mark - 自定义方法
/**
 *  保存图片到相机胶卷
 */
- (void)savedPhotosAlbum
{
    // UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(a:b:c:), nil);
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 *  通过UIImageWriteToSavedPhotosAlbum函数写入图片完毕后就会调用这个方法
 *
 *  @param image       写入的图片
 *  @param error       错误信息
 *  @param contextInfo UIImageWriteToSavedPhotosAlbum函数的最后一个参数
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
    }
    
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
