//
//  YHCalendarData.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCalendarTool.h"
#import "YHCalendarModel.h"

@interface YHCalendarData : NSObject
- (void)GetData:(NSString *)urlStr Success:(void(^)(NSArray *result))success;
@end
