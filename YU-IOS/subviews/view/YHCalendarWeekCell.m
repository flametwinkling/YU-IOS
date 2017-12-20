//
//  YHCalendarWeekCell.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHCalendarWeekCell.h"

@interface YHCalendarWeekCell()
{
    UILabel * _label;
    UIView  * _nowDayView;
}
@end

@implementation YHCalendarWeekCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        
        _nowDayView = [[UIView alloc] initWithFrame:CGRectMake((width - 28)/2, 0, 28, 28)];
        _nowDayView.layer.cornerRadius = 14;
        _nowDayView.layer.borderWidth = 0;
        _nowDayView.clipsToBounds = YES;
        [self.contentView addSubview:_nowDayView];
        
        _label = [[UILabel alloc] initWithFrame:_nowDayView.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:16];
        [_nowDayView addSubview:_label];
        
        
    }
    return self;
}

- (void)setWeekName:(NSString *)weekName {
    _label.text = weekName;
}

@end
