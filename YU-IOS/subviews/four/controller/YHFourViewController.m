//
//  YHFourViewController.m
//  YU-IOS
//
//  Created by yuhao on 2018/2/27.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import "YHFourViewController.h"
#import "YHDropDownMenuView.h"

@interface YHFourViewController ()

@end

@implementation YHFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YHDropDownMenuView *dropdownView = [[YHDropDownMenuView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y, VCSizeWidth, TitleBarHeight)];
    dropdownView.titleArr = @[@"听听力",@"练口语"].mutableCopy;
    dropdownView.dataSourceArr = @[@[@"1",@"2",@"3"],@[@"4",@"5",@"6"]].mutableCopy;
    dropdownView.startY = self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y;
    [self.view addSubview:dropdownView];
}


@end
