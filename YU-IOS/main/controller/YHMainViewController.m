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
#import "YHMainThreeViewController.h"
#import "YHFourViewController.h"
#import "YHFiveViewController.h"
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
   // self.navigationItem.title = @"首页";
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
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"three" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(onClick2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(20);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setTitle:@"four" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(onClick3) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn3];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).offset(20);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];

    UIButton *btn4 = [[UIButton alloc] init];
    [btn4 setTitle:@"five" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(onClick4) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn4];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn3.mas_bottom).offset(20);
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

- (void)onClick2{
  //  NSLog(@"v =%@, vs =%@",mainthreevalue,mainthreevalues);
    YHMainThreeViewController *threeVC = [[YHMainThreeViewController alloc] init];
  //  NSLog(@"v =%@, vs =%@",mainthreevalue,mainthreevalues);

    [self.navigationController pushViewController:threeVC animated:YES];
}

-(void)onClick3{
    [self.navigationController pushViewController:[[YHFourViewController alloc] init] animated:YES];
}

- (void)onClick4{
    [self.navigationController pushViewController:[[YHFiveViewController alloc] init] animated:YES];
}



@end
