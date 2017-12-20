//
//  YHMainViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/12.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHMainViewController.h"
#import "YHMainFirstViewController.h"
#import "YHMainSecondViewController.h"
#import "YHSuspendBtn.h"
@interface YHMainViewController ()

{
    BOOL _isSignined;
}

@property(nonatomic,strong)YHSuspendBtn *folatManage;

@end

@implementation YHMainViewController


static YHMainViewController *_instance;
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [YHMainViewController new];
    });
    return _instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self subviews];
}

- (void)subviews{
    UIButton *btn0 = [[UIButton alloc] init];
    [btn0 setTitle:@"first" forState:UIControlStateNormal];
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn0];
    
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.navigationController.navigationBar.frame.size.height + 10);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];
    
    
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"sencond" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(btn0.mas_bottom).offset(20);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];

    
    [self createSuspendBtn];
}

- (void)createSuspendBtn{
    _isSignined = NO;
    self.folatManage = [YHSuspendBtn defaultManagerWithImageName:nil];

    __weak typeof(self)weekself = self;
    //浮标的监听
    [self.folatManage setOnclickListenerWithPayCent:^{
        
    } PerCentBlock:^{
        
    } LogoutBlock:^{
        
    } UpUserBlock:^{
        
    } OpenSiginBlock:^{
        _isSignined = YES;
        [weekself.folatManage dissmissWindow];
        [weekself.navigationController pushViewController:[[YHMainSecondViewController alloc] init] animated:YES];

    }];
}

- (void)viewWillAppear:(BOOL)animated{
    if (_isSignined == NO) {
        //显示浮标
        [self.folatManage showWindow];

    }else{
        //隐藏图标
        [self.folatManage dissmissWindow];
    }
}


-(void)onClick{
    [self.navigationController pushViewController:[[YHMainFirstViewController alloc] init] animated:YES];
}

-(void)onClick1{
    [self.navigationController pushViewController:[[YHMainSecondViewController alloc] init] animated:YES];
}



@end
