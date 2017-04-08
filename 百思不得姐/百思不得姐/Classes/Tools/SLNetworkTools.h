//
//  SLNetworkTools.h
//  百思不得姐
//
//  Created by Anthony on 2017/4/8.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, SLRequestType) {
    SLRequestTypeGET = 0,
    SLRequestTypePOST = 1
};

@interface SLNetworkTools : AFHTTPSessionManager


+ (__kindof SLNetworkTools*)sharedNetworkTools;

- (void)requestmethodType:(SLRequestType)methodType urlString:(NSString *)urlString parameters:(NSDictionary *)parameters finished:(void (^)(NSDictionary *result, NSError *error))finished;
@end
