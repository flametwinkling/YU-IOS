//
//  YHPlayerAnimation.m
//  ssssss
//
//  Created by yuhao on 2017/9/29.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHPlayerAnimation.h"

@interface YHPlayerAnimation()
{
    BOOL _isAnimatoning;
    NSArray *_animationLayers;
}
@end

@implementation YHPlayerAnimation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) commonInit {

    _isAnimatoning = NO;
    
    //添加柱状Layer
    NSMutableArray *animationLayers = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.pillarNum; i ++) {
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = self.pillarColor.CGColor;
        [self.layer addSublayer:layer];
        
        [animationLayers addObject:layer];
    }
    _animationLayers = animationLayers;
}

-(void)layoutSubviews{
    
    //bounds改变后需要重设Layer的Frame和动画的Path
    for (CAShapeLayer *layer in _animationLayers) {
        layer.frame = self.bounds;
    }
    [self updateAnimationPath];
    
    [super layoutSubviews];
}

#pragma mark - Update Path
- (void) updateAnimationPath {
    
    CGFloat height = CGRectGetHeight(self.frame);
    NSMutableArray * pillarHeighs = [NSMutableArray array];
    for (int i=0; i<self.pillarNum; i++) {
        float pillarheight = height*(float)(random()%4 + 7)/10;
        [pillarHeighs addObject:[NSString stringWithFormat:@"%f",pillarheight]];
    }
    NSInteger pillarNumber = pillarHeighs.count;
    NSInteger pillarWidth = self.pillarWidth;
    NSInteger margin = (CGRectGetWidth(self.frame) - pillarNumber * pillarWidth) / (pillarNumber - 1);
    
    for (int i = 0; i < _animationLayers.count; i ++) {
        CAShapeLayer *layer = _animationLayers[i];
        CGFloat pillarHeight = [pillarHeighs[i] floatValue];
        CGFloat x = pillarWidth + (pillarWidth + margin) * i;
        CGPoint startPoint = CGPointMake(x, CGRectGetHeight(self.frame));
        CGPoint toPoint = CGPointMake(x, height - pillarHeight);
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addLineToPoint:toPoint];
        
        layer.path = path.CGPath;
    }
    
    if (_isAnimatoning) {
        [self startAnimation];
    }
}


#pragma mark - Setter and getter
- (void)setPillarWidth:(CGFloat)pillarWidth {
    if (_pillarWidth == pillarWidth) {
        return;
    }
    _pillarWidth = pillarWidth;
    for (CAShapeLayer * layer in _animationLayers) {
        layer.lineWidth = self.pillarWidth;
    }
}


- (void)setPillarColor:(UIColor *)pillarColor {
    if (_pillarColor == pillarColor) {
        return;
    }
    _pillarColor = pillarColor;
    for (CAShapeLayer * layer in _animationLayers) {
        layer.strokeColor = self.pillarColor.CGColor;
    }
}

#pragma mark - Public method
- (void) startAnimation {
    _isAnimatoning = YES;
    
    //先移除所有动画
    for (CAShapeLayer * layer in _animationLayers) {
        [layer removeAllAnimations];
    }
    
    /*通过这些数值来调整动画效果*/
    //每个Layer动画时切换的高度值（0~1）
    NSMutableArray * values = [NSMutableArray array];
    //每个Layer的动画时长
    NSMutableArray * dutions = [NSMutableArray array];
    for (int i=0; i<self.pillarNum; i++) {
        NSArray *value = @[@1.0, @((float)(random()%4 + 7)/10), @((float)(random()%6)/10), @((float)(random()%5)/10), @((float)(random()%3 + 8)/10), @((float)(random()%2 + 9)/10), @1.0];
        [values addObject:value];
        
        float dution = (float)(random()%2 + 9)/10;
        [dutions addObject:[NSString stringWithFormat:@"%f",dution]];
        
    }
    
    
    int i = 0;
    for (CAShapeLayer * layer in _animationLayers) {
        layer.lineWidth = self.pillarWidth;
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        animation.values = values[i];
        animation.duration = [dutions[i] floatValue];
        animation.repeatCount = HUGE_VAL;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [layer addAnimation:animation forKey:@"ESSEQAnimation"];
        i ++;
        
    }
    
}

- (void) stopAnimation {
    _isAnimatoning = NO;
    
    //先移除所有动画
    for (CAShapeLayer * layer in _animationLayers) {
        [layer removeAllAnimations];
    }
}


@end
