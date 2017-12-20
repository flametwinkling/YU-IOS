//
//  YHTransitionAnimation.m
//  Isayb04
//
//  Created by dev on 16/3/28.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "UIView+YHTransitionAnimation.h"

@implementation UIView(YHTransitionAnimation)

- (void)setTransitionAnimationType:(YHTransitionAnimationType)transtionAnimationType toward:(YHTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration
{
    CATransition * transition = [CATransition animation];
    transition.duration = duration;
    NSArray * animations = @[@"cameraIris",
                             @"cube",
                             @"fade",
                             @"moveIn",
                             @"oglFlip",
                             @"pageCurl",
                             @"pageUnCurl",
                             @"push",
                             @"reveal"];
    NSArray * subTypes = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    transition.type = animations[transtionAnimationType];
    transition.subtype = subTypes[transitionAnimationToward];
    
    [self.layer addAnimation:transition forKey:nil];
}

@end
