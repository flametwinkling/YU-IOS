//
//  YHDatasourceNetData.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHRootNet.h"

@interface YHDatasourceNetData : NSObject


/**
 request

 @param urlStr url
 @param parameter patameter
 @param completion completion
 */
-(void)Request:(NSString *_Nullable)urlStr Parameter:(NSDictionary *_Nullable)parameter completion:(void (^_Nullable)(id _Nonnull result, BOOL isSuccess))completion;

@end
