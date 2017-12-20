//
//  YHMainSecondViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/11.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHMainSecondViewController.h"
#import "YHSigninTopView.h"
#import "YHCalenderView.h"

#define RightBarTag 1112

@interface YHMainSecondViewController ()<YHSIgninTopviewDelegate>
{
    YHSigninTopView *topview;
    UICountingLabel *integralBel;
}
@end

@implementation YHMainSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleBel = [[UILabel alloc] init];
    titleBel.text = @"签到";
    titleBel.textColor = [UIColor whiteColor];
    [titleBel setFont:[UIFont systemFontOfSize:20]];
    [titleBel setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleBel;
    
    
    integralBel = [[UICountingLabel alloc] init];
    integralBel.textColor = [UIColor whiteColor];
    [integralBel setFont:[UIFont systemFontOfSize:14]];
    integralBel.tag = RightBarTag;
    integralBel.method = UILabelCountingMethodEaseInOut;
    integralBel.format = [NSString stringWithFormat:@"当前积分：%d",1000];
    [integralBel sizeToFit];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:integralBel];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createCalendar];
}

- (void)createTop:(YHCalendarModel *)model{
    topview = [[YHSigninTopView alloc] init];
    topview.countinuousSigninedDays = [model.countinuousSigninedDays integerValue];
    topview.isSignined = model.isSigninedToday;
    [self.view addSubview:topview];
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.navigationController.navigationBar.frame.size.height + 10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    topview.delegate = self;
}

- (void)createCalendar{
    [[[YHCalendarData alloc] init] GetData:SIGNIN_URL Success:^(NSArray *result) {
        [self createTop:result.firstObject];
        YHCalenderView *calendarview = [[YHCalenderView alloc] init];
        calendarview.sourceArray = result;
        [self.view addSubview:calendarview];
        [calendarview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topview.mas_bottom).mas_offset(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(VCSizeHeight - 200 - 10);
        }];
    }];

}

- (void)signinClick{
    integralBel.format = @"当前积分：%d";
    [integralBel countFrom:1000 to:1010 withDuration:1];
}

@end
