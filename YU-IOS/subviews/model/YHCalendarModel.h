//
//  YHCalendarModel.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCalendarModel : NSObject

@property (nonatomic, copy) NSDate * date;//日期
@property (nonatomic, assign) NSInteger day;// 某天
@property (nonatomic, assign) BOOL isNowDay;//是否是今天(1:今天 选中; 0不是今天 不选中)
@property (nonatomic, assign) BOOL isEnable;//是否可以点击(是否是本月)
@property (nonatomic, assign) BOOL isSelected;//是否点击
@property (nonatomic, assign) BOOL isSignInSuccess; //签到完成
@property (nonatomic, assign) BOOL isSignInFaile; //签到失败

@property (nonatomic, copy) NSString * prizeName;//cell中//会员日、积分、礼金券

@property (nonatomic, copy) NSString * signinedDays;
@property (nonatomic, retain) NSArray * prizes;
@property (nonatomic, retain) NSArray * signinedThisMoth;
@property (nonatomic, copy) NSString * countinuousSigninedDays;
@property (nonatomic, assign) BOOL  isSigninedToday;
@end
