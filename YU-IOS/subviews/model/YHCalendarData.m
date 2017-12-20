//
//  YHCalendarData.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHCalendarData.h"

@interface YHCalendarData()
{
    BOOL nowDayIsSignIn;
}

@property (nonatomic, retain) YHCalendarModel *calendarModel;
@end

@implementation YHCalendarData

- (void)GetData:(NSString *)urlStr Success:(void(^)(NSArray *result))success{
    YHDatasourceNetData *datasource = [[YHDatasourceNetData alloc] init];
    [datasource Request:urlStr Parameter:nil completion:^(id  _Nonnull result, BOOL isSuccess) {
        if (isSuccess) {
            self.calendarModel = [YHCalendarModel yy_modelWithJSON:result];
            NSDate *date = [NSDate date];
            NSInteger firstWeekday = [YHCalendarTool firstWeekdayInThisMonth:date];
            NSInteger daysInThisMonth = [YHCalendarTool totaldaysInMonth:date];
            NSInteger daysInLastMonth = [YHCalendarTool totaldaysInMonth:[YHCalendarTool lastMonth:date]];
            NSInteger nowDay = [YHCalendarTool day:date];
            nowDayIsSignIn = YES;
            
            success([self AllDays:firstWeekday AndLastMonthDays:daysInLastMonth AndThisMonthDays:daysInThisMonth AndNowDay:nowDay]);

        }
    }];
    
}

- (void)setCalendarModel:(YHCalendarModel *)calendarModel{
    _calendarModel = calendarModel;
}

- (NSArray *)AllDays:(NSInteger)firstWeekday AndLastMonthDays:(NSInteger)daysInLastMonth AndThisMonthDays:(NSInteger)daysInThisMonth AndNowDay:(NSInteger)nowDay
{
    NSMutableArray  *daysArray = [NSMutableArray arrayWithCapacity:42];
    for (int i = 0; i < 42; i++) {
        YHCalendarModel *model = [[YHCalendarModel alloc] init];
        model.isSignInFaile = NO;
        model.isSignInSuccess = NO;
        model.isSelected = NO;
        model.isEnable = YES;
        model.isSigninedToday = _calendarModel.isSigninedToday;
        model.countinuousSigninedDays = _calendarModel.countinuousSigninedDays;
        NSInteger day = 0;


        NSArray *prizes = _calendarModel.prizes;
        for (int j = 0; j<prizes.count; j++) {
            NSDictionary *prizeDic = prizes[j];
            if ([prizeDic.allKeys.lastObject intValue] == i) {
                model.prizeName = prizeDic.allValues.lastObject;
            }
        }
        NSArray *signinedThisMoth = _calendarModel.signinedThisMoth;
        for (int t = 0; t<signinedThisMoth.count; t++) {
            if ([signinedThisMoth[t] intValue] == i) {
                model.isSignInSuccess = YES;
            }
        }
        if (i < nowDay + firstWeekday - 1) {
            model.isSignInFaile = YES;

        }else if(i == nowDay + firstWeekday - 1){
            model.isSelected = YES;
        }

        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            model.isEnable = NO;
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            model.isEnable = NO;
        }else{
            day = i - firstWeekday + 1;
        }
        model.day = day;

        [daysArray addObject:model];
    }
    return daysArray;
}

@end
