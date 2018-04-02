//
//  YHAdViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/12.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHAdViewController.h"
#import "AdModel.h"
#import "AdData.h"

#import "YHGuideView.h"

@interface YHAdViewController ()
{
    int _waiteTimes;
}

@property (nonatomic, strong) AdModel *adModel;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, retain) NSArray *dataArr;

@property (nonatomic, retain) UIImageView* imageView;


@end

@implementation YHAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self loadAdData];
    
    AdData *addata = [[AdData alloc] init];
    // url 和 参数
    [addata loadAdData:AD_URL Result:^(NSArray *resultArr) {
        AdModel *model =  resultArr[0];
        _dataArr = resultArr;
        if (model.adShow == YES) {
            self.adModel = resultArr[resultArr.count - 1];
            [self.timer fire];
        }else{
            // 切换到主控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = [YHTabBarController sharedInstance];
        }
    }];
}

#pragma mark -
#pragma mark set imageview
- (UIImageView *)imageView{
    if (!_imageView ) {
        _imageView = [UIImageView new];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImageV)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

#pragma mark -
#pragma mark set Model

-(void)setAdModel:(AdModel *)adModel{
    _adModel = adModel;
    // 宽度为 0 直接返回
    if (!adModel.w) return;
    // 计算高度,按原比例取全屏
    CGFloat h = adModel.h * ScreenWidth / adModel.w;
    [self.view insertSubview:({
        self.imageView.frame = CGRectMake(0, 0, ScreenWidth, h);
        [_imageView sd_setImageWithURL:[NSURL URLWithString:adModel.ad_url] placeholderImage:nil options:kNilOptions];
        [_imageView setTransitionAnimationType:YHTransitionAnimationTypeFade toward:YHTransitionAnimationTowardFromLeft duration:0.5];
        _imageView;
    }) atIndex:0];
}

#pragma mark -
#pragma mark 懒加载 timer
- (NSTimer *)timer {
    if (!_timer) {
        // 创建倒计时定时器
        _waiteTimes = (int)(_dataArr.count - 1);
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refreshTitle) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)refreshTitle{
    // 更新按钮的 title 显示
    [_SkipBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",_waiteTimes] forState:UIControlStateNormal];
    self.adModel = _dataArr[_waiteTimes];

    // 结束
    if ((_waiteTimes --) == 0) {
        [self SkipBtn:_SkipBtn];
    }
}


#pragma mark -
#pragma mark 跳转事件
- (IBAction)SkipBtn:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    
    // 切换到主控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = [YHTabBarController sharedInstance];;
    // 切换到引导页
    [YHGuideView show];
}

-(void)tapAdImageV{
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_adModel.ad_url]]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_adModel.ad_url]];
      }
}

//#pragma mark -
//#pragma mark load  data
//
//- (void)loadAdData {
//
//    // url 和 参数
//    NSString *urlStr = @"http://mobads.baidu.com/cpro/ui/mads.php";
//    NSDictionary *paramters = @{@"code2": @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"};
//    YHDatasourceNetData *netdata = [[YHDatasourceNetData alloc] init];
//    [netdata Request:urlStr Parameter:paramters completion:^(id  _Nonnull result, BOOL isSuccess) {
//        if (isSuccess) {
//            NSArray * adArray = result[@"ad"];
//            if (adArray.count==0) return;
//            // 取出第一个字典
//            NSDictionary* adDict = adArray.firstObject;
//            self.adModel = [AdModel yy_modelWithJSON:adDict];
//        }else{
//
//        }
//    }];
//}


@end
