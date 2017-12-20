//
//  YHSigninTopView.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/11.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSigninTopView;
@protocol YHSIgninTopviewDelegate <NSObject>

- (void)signinClick;

@end

@interface YHSigninTopView : UIView
@property (nonatomic,weak)id <YHSIgninTopviewDelegate> delegate;

@property (nonatomic,assign) NSInteger countinuousSigninedDays;

@property (nonatomic,assign) BOOL isSignined;
@end
