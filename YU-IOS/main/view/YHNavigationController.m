//
//  YHNavigationViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/11.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHNavigationController.h"

@interface YHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YHNavigationController

+ (void)initialize {
    
    if (self == [YHNavigationController class]) {
        // 系统适配
        UINavigationBar *navBar = nil;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            // 9.0 前支持的方法
            navBar = [UINavigationBar appearanceWhenContainedIn:[YHNavigationController class], nil];
        } else {
            // 9.0 后支持的方法
            navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[YHNavigationController class]]];
        }
        // 设置导航栏的背景图片
        [navBar setBackgroundImage:[UIImage imageNamed:@"title-bar"] forBarMetrics:UIBarMetricsDefault];
        // 设置导航栏的标题字体
        [navBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]}];
        // 设置 item 的显示属性
        UIBarButtonItem *item = [UIBarButtonItem appearance];
        // UIControlStateNormal
        NSDictionary *itemAttrs = @{
                                    NSForegroundColorAttributeName: [UIColor blackColor],
                                    NSFontAttributeName: [UIFont systemFontOfSize:17]
                                    };
        [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
        // UIControlStateDisabled
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果自定定制了左边的返回按钮, 就没有系统自带的左划返回功能了!!!
    // 修改
    //    self.interactivePopGestureRecognizer.delegate = nil;
    // 这样会造成界面卡住!!!所以不行!!!
    
    // 增加全屏 pop 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    [self.view addGestureRecognizer:pan];
    // 这样写同样存在界面卡住现象, 当我们在根控制器拖拽时,
    // 即想移除一个导航控制器的根控制器时, 同样会存在卡死现象
    // bug解决思路: 通过手势代理, 让其在根控制器中不响应手势操作即可!!!

    pan.delegate = self;
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate

// 手势开始时调用, 返回值代表手势是否允许执行
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 当当前控制器不是根控制器时, 我们允许手势执行
    return (self.viewControllers.count > 1);
    
}

#pragma mark -

/** 监听导航控制器的 push 动作 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 如果childViewControllers的个数大于0, 代表根控制器已经push了
    if (self.childViewControllers.count > 0) { // 非根控制器
        // 这样定制了左边按钮在控制器的view加载之前, 我们可以在控制器的loadView中进行重新定制左边按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:({
            // 这里定制左边的按钮, 让其成为返回按钮
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//            [btn setTitle:@"返回" forState:UIControlStateNormal];
//            [btn setTitle:@"返回" forState:UIControlStateHighlighted];
            // 调整content的内容边距, 这样可以让btn看上去左移了
            // 这样调整后的按钮外部的内容是可以点击的
            // 调整为0的原因是, 开始我们的按钮距离左边的距离是16
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *btnIcon = [[UIImageView alloc] init];
            btnIcon.image = [UIImage imageNamed:@"back"];
            [btn addSubview:btnIcon];
            [btnIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5);
                make.top.mas_equalTo(5);
                make.bottom.mas_equalTo(-10);
                make.right.mas_equalTo(-20);
            }];

            btn;
        })];
        

        // 如果自定定制了左边的返回按钮, 就没有系统自带的左划返回功能了!!!
        
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句话放在后面和放在前面是有区别的
    // 前面: 在子控制器中不可再次定制返回按钮
    // 后面: 在子控制器中可以再次定制返回按钮
    [super pushViewController:viewController animated:animated];
}

/** 返回按钮点击了 */
- (void)back {
    // 导航控制器 pop 动作
    [self popViewControllerAnimated:YES];
}

@end
