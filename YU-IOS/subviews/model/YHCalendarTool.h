//
//  YHCalendarTool.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/14.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCalendarTool : NSObject

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;

@end
