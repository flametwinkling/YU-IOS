//
//  YHPlayerAnimation.h
//  ssssss
//
//  Created by yuhao on 2017/9/29.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPlayerAnimation : UIControl

/*! 开始动画 */
- (void)startAnimation;

/*! 结束动画 */
- (void) stopAnimation;

/*! 柱子的宽度 */
@property (assign, nonatomic) CGFloat pillarWidth;

/*! 柱子的颜色 */
@property (strong, nonatomic) UIColor * pillarColor;

/* 柱子的数量 */
@property (assign, nonatomic) int pillarNum;

/* 新建动画 */
- (void) commonInit;
@end
