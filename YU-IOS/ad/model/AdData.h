//
//  AdData.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/8.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdData : NSObject

- (void)loadAdData:(NSString *)urlstr Result:(void(^)(NSArray *resultArr))getresult;

@end
