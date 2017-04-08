//
//  SLNetworkTools.m
//  百思不得姐
//
//  Created by Anthony on 2017/4/8.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "SLNetworkTools.h"

@implementation SLNetworkTools

static SLNetworkTools *instance_;

+ (__kindof SLNetworkTools*)sharedNetworkTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] initWithBaseURL:nil sessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        instance_.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance_;
}



- (void)requestmethodType:(SLRequestType)methodType urlString:(NSString *)urlString parameters:(NSDictionary *)parameters finished:(void (^)(NSDictionary *result, NSError *error))finished
{
    // 1.定义成功的回调
    void (^successCallBack)() = ^(NSURLSessionDataTask *task, id result) {
        finished(result, nil);
    };
    
    // 2.定义失败的回调
    void (^failureCallBack)() = ^(NSURLSessionDataTask *task, NSError *error) {
        finished(nil, error);
    };
    
    // 3.发送网络请求
    if (methodType == SLRequestTypeGET) {
        [self GET:urlString parameters:parameters progress:nil success:successCallBack failure:failureCallBack];
    } else {
        [self POST:urlString parameters:parameters progress:nil success:successCallBack failure:failureCallBack];
    }
}


@end
