//
//  YHMainViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/12.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHMainViewController.h"
#import "WMGiftDetaultAnimationView.h"
@interface YHMainViewController ()

@end

@implementation YHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self subviews];
}

- (void)subviews{
    UIButton *btn0 = [[UIButton alloc] init];
    [btn0 setTitle:@"d" forState:UIControlStateNormal];
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn0];
    
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];
}

-(void)onClick{
    WMGiftDetaultAnimationView *animationView = [WMGiftDetaultAnimationView sharedDefaultAnimationView];
    [animationView show];
}



@end
