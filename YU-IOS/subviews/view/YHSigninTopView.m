//
//  YHSigninTopView.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/11.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHSigninTopView.h"

@interface YHSigninTopView()
{
    UIImageView *bgView;
    UIImageView *signinIv;
    UIButton *signinBtn;
    UILabel *signinbel;
    
    UIImageView * tickImgView;
    CGFloat _tickL;
    CGFloat _tickT;
    CGFloat _tickW;
    CGFloat _tickH;
    
    UILabel *interaglbel;
}

@property (nonatomic, retain) UIImageView *siginSuccessView;

@end

@implementation YHSigninTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.userInteractionEnabled = YES;

    bgView = [[UIImageView alloc] initWithFrame:rect];
    [bgView setImage:[UIImage imageNamed:@"signIn_bg"]];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    signinbel = [[UILabel alloc] init];
    signinbel.textAlignment = NSTextAlignmentCenter;
    signinbel.font = [UIFont systemFontOfSize:16];
    signinbel.textColor = [UIColor whiteColor];
    signinbel.backgroundColor = [UIColor clearColor];
    signinbel.numberOfLines = 0;
    signinbel.lineBreakMode = NSLineBreakByWordWrapping;
    [bgView addSubview:signinbel];
    [signinbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(-55);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(180);
    }];
    signinbel.text = [self labelWithSignDay:self.countinuousSigninedDays Tag:0];

    
    if (_isSignined == NO) {
        signinIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signIn_circle_bg"]];
        signinIv.backgroundColor = [UIColor clearColor];
        signinIv.userInteractionEnabled = YES;
        [bgView addSubview:signinIv];
        [signinIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.width.height.mas_equalTo(85);
        }];
        
        
        signinBtn = [[UIButton alloc] init];
        [signinBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signinBtn setTitleColor:SColor forState:UIControlStateNormal];
        [signinBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
        [signinBtn addTarget:self action:@selector(signinClick) forControlEvents:UIControlEventTouchUpInside];
        [signinIv addSubview:signinBtn];
        [signinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(signinIv);
            make.width.height.mas_equalTo(70);
        }];
        signinBtn.layer.cornerRadius = signinBtn.frame.size.width/2;
        signinBtn.userInteractionEnabled = YES;
        

    }else{
        self.siginSuccessView.hidden = NO;
        tickImgView.frame = CGRectMake(_tickL, _tickT, _tickW, _tickH);
        signinbel.text = [self labelWithSignDay:101 Tag:1];

    }
}

- (UIImageView *)siginSuccessView{
    if (!_siginSuccessView) {
        _siginSuccessView = [[UIImageView alloc] init];
        _siginSuccessView.image = [UIImage imageNamed:@"signIn_success_calendar"];
        _siginSuccessView.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_siginSuccessView];
        _siginSuccessView.hidden = YES;
        [_siginSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.width.height.mas_equalTo(60);
        }];

        _tickW = 22;
        _tickH = 16;
        _tickL = (60 - _tickW)/2;
        _tickT = (60 - _tickH)/2 + 5;
        tickImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_tickL, _tickT, 0, _tickW)];
        tickImgView.image = [UIImage imageNamed:@"signIn_success_right"];
        [_siginSuccessView addSubview:tickImgView];
    }
    return _siginSuccessView;
}

- (void)signinClick{
    if (_isSignined == YES || signinBtn.selected == YES) {
        return;
    }
    signinbel.hidden = YES;
    _isSignined = YES;
    signinBtn.selected = YES;
    [signinIv removeFromSuperview];
    
    
    signinbel.text = [self labelWithSignDay:101 Tag:1];
    self.siginSuccessView.hidden = NO;
    [self addAnimation];
}


- (NSString *)labelWithSignDay:(NSInteger)signDay Tag:(NSInteger)overS{
    return overS == 1 ? [NSString stringWithFormat:@"签到成功!"] : [NSString stringWithFormat:@"您已连续签到%zd天", signDay];
}

- (void)addAnimation{
    _siginSuccessView.center = CGPointMake(CGRectGetWidth(bgView.bounds)/2, - 50);
    tickImgView.frame = CGRectMake(_tickL, _tickT, 0, _tickH);
    
    [UIView animateWithDuration:1.5f
                          delay:0.f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _siginSuccessView.center = CGPointMake(CGRectGetWidth(bgView.bounds)/2, CGRectGetHeight(bgView.bounds)/2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2 animations:^{
                            tickImgView.frame = CGRectMake(_tickL, _tickT, _tickW, _tickH);
                         } completion:^(BOOL finished) {
                             interaglbel = [[UILabel alloc] initWithFrame:_siginSuccessView.frame];
                             interaglbel.text = @"+10";
                             interaglbel.textColor = [UIColor redColor];
                             interaglbel.textAlignment = NSTextAlignmentCenter;
                             [interaglbel setFont:[UIFont systemFontOfSize:18]];
                             [bgView addSubview:interaglbel];

                             [UIView animateWithDuration:1 animations:^{
                                 [interaglbel setTransitionAnimationType:YHTransitionAnimationTypeReveal toward:YHTransitionAnimationTowardFromTop duration:1];
                                 interaglbel.alpha = 0;
                             } completion:^(BOOL finished) {
                                 if (self.delegate && [self.delegate respondsToSelector:@selector(signinClick)]) {
                                     [self.delegate signinClick];
                                 }

                             }];

                         }];
                         signinbel.hidden = NO;

                     }];

}




@end
