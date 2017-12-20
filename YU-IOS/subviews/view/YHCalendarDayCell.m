//
//  YHCalendarDayCell.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHCalendarDayCell.h"

@interface YHCalendarDayCell()
{
    UILabel * _label;
    UIImageView * _bgImg;
    UIView * _pointView;
    
    UILabel * _descLabel;
    
}

@end

@implementation YHCalendarDayCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat bgH = 28;
        CGFloat top = 5;
        _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake((width - bgH)/2.0, top, bgH, bgH)];
        _bgImg.backgroundColor = [UIColor clearColor];
        _bgImg.layer.cornerRadius = bgH/2.0;
        _bgImg.clipsToBounds = YES;
        [self.contentView addSubview:_bgImg];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, top, width, bgH)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:18];
        _label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_label];
        top += 29;
        _pointView = [[UIView alloc] initWithFrame:CGRectMake((width - 6)/2.0, top, 6, 6)];
        _pointView.layer.cornerRadius = 3;
        _pointView.clipsToBounds = YES;
        _pointView.hidden = YES;
        [self.contentView addSubview:_pointView];
        top += 6 + 3;
        CGFloat descLableH = 13;// 原来写的 height - top== 不准确
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, width, descLableH)];
        _descLabel.text = @"";
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = [UIColor purpleColor];
        _descLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_descLabel];
        
        self.contentView.clipsToBounds = YES;
        
    }
    return self;
}


- (void)setCalendarModel:(YHCalendarModel *)model {
    
    _label.text = [NSString stringWithFormat:@"%zd", model.day];
    _descLabel.text = model.prizeName;
    if(model.isEnable) {
        _label.textColor = [UIColor blackColor];
    }
    else {
        _label.textColor = [UIColor grayColor];
    }
    
    if(model.isSelected) {
        _bgImg.backgroundColor = SColor;
        _label.textColor = [UIColor whiteColor];
    }
    else {
        _bgImg.backgroundColor = [UIColor clearColor];

    }
    
    if(model.isSignInSuccess) {
        _pointView.hidden = NO;
        _pointView.backgroundColor = SColor;

    }else if(model.isSignInFaile){
        _pointView.hidden = NO;
        _pointView.backgroundColor = [UIColor redColor];

    }else {
        _pointView.hidden = YES;
    }
    
}


@end
