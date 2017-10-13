//
//  YHRootNet.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHRootNet : NSObject

+ (void)GET:(NSString *)urlStr parameters:(NSDictionary *)paramter sucess:(void (^)(NSData *responseObject))success faile:(void(^)(NSError *errorg))falie;

+ (void)POST:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(void(^)(NSData *responseObject))success faile:(void(^)(NSError *errorP))faile;

@end
