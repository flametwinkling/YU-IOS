//
//  YHMainFirstViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/11.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHMainFirstViewController.h"
#import "WMGiftDetaultAnimationView.h"

@interface YHMainFirstViewController ()
{
    WMGiftDetaultAnimationView *animationView;
}
@end

@implementation YHMainFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动画";
}

- (void)viewWillAppear:(BOOL)animated{
    animationView = [WMGiftDetaultAnimationView sharedDefaultAnimationView];
    [animationView show];
}

- (void)viewWillDisappear:(BOOL)animated{
    [animationView hiden];
}


@end
