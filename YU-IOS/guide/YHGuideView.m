//
//  YHGuideView.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/16.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHGuideView.h"

@implementation YHGuideView

+ (instancetype)pushGuideView {
    return [[NSBundle mainBundle] loadNibNamed:@"YHGuideView" owner:nil options:nil].lastObject;
}

+ (void)show
{
    NSString *versionKey = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
    
    if (currentVersion != oldVersion)
    {
        [[UIApplication sharedApplication].keyWindow addSubview:({
            YHGuideView *pushGuideView = [YHGuideView pushGuideView];
            pushGuideView.frame = [UIApplication sharedApplication].keyWindow.bounds;
            pushGuideView;
        })];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (IBAction)ensureClick {
    [UIView animateWithDuration:1.0 animations:^{
        self.fY = self.fHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


@end
