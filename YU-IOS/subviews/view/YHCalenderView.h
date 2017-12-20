//
//  YHCalenderView.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHCalendarData.h"

@interface YHCalenderView : UIView

@property (nonatomic, retain) UICollectionView *calendarCollection;//日历样式
@property (nonatomic, retain)  NSArray * sourceArray;//日历 数据源

@end
