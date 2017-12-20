//
//  YHTransitionAnimation.h
//  Isayb04
//
//  Created by dev on 16/3/28.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YHTransitionAnimationTypeCameraIris,
    //相机
    YHTransitionAnimationTypeCube,
    //立方体
    YHTransitionAnimationTypeFade,
    //淡入
    YHTransitionAnimationTypeMoveIn,
    //翻转
    YHTransitionAnimationTypePageCurl,
    //翻去一页
    YHTransitionAnimationTypePageUnCurl,
    //添上一页
    YHTransitionAnimationTypePush,
    //平移
    YHTransitionAnimationTypeReveal,

}YHTransitionAnimationType;

typedef enum
{
    YHTransitionAnimationTowardFromLeft,
    YHTransitionAnimationTowardFromRight,
    YHTransitionAnimationTowardFromTop,
    YHTransitionAnimationTowardFromBottom
}YHTransitionAnimationToward;


@interface  UIView (YHTransitionAnimation)


- (void)setTransitionAnimationType:(YHTransitionAnimationType)transtionAnimationType toward:(YHTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration;

@end
