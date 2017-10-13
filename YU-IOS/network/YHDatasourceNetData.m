//
//  YHDatasourceNetData.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHDatasourceNetData.h"

@implementation YHDatasourceNetData

#pragma mark -
#pragma mark Ad
-(void)Request:(NSString *_Nullable)urlStr Parameter:(NSDictionary *_Nullable)parameter completion:(void (^_Nullable)(id _Nonnull result, BOOL isSuccess))completion {
    [YHRootNet GET:urlStr parameters:parameter sucess:^(NSData *responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        completion(json,YES);
    } faile:^(NSError *errorg) {
        
    }];
}

@end
