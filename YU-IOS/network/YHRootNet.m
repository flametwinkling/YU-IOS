//
//  YHRootNet.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHRootNet.h"

@implementation YHRootNet

+ (void)GET:(NSString *)urlStr parameters:(NSDictionary *)paramter sucess:(void (^)(NSData *responseObject))success faile:(void(^)(NSError *errorg))falie{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:urlStr parameters:paramter progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"GET: downprogress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        falie(error);
        NSLog(@" GET: error == %@",error);
    }];
}


+ (void)POST:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(void(^)(NSData *responseObject))success faile:(void(^)(NSError *errorP))faile{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"POST: uploadprogress = %@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        faile(error);
        NSLog(@"POST: error = %@",error);
    }];
}

@end
