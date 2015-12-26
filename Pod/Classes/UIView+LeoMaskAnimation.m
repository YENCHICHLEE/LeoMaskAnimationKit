//
//  UIView+LeoMaskAnimation.m
//  LeoMaskAnimationKit
//
//  Created by huangwenchen on 15/12/26.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "UIView+LeoMaskAnimation.h"

@implementation UIView (LeoMaskAnimation)


-(void)leo_animateMaskFromRect:(CGRect)fromRect
                    toRect:(CGRect)toRect
                  duration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                   options:(LeoMaskAnimationOptions)options{
    UIBezierPath * fromPath = [UIBezierPath bezierPathWithRect:fromRect];
    UIBezierPath * toPath = [UIBezierPath bezierPathWithRect:toRect];
    [self leo_animateMaskFromPath:fromPath toPath:toPath duration:duration delay:delay options:options];
}

-(void)leo_animateMaskFromPath:(UIBezierPath *)fromPath
                    toPath:(UIBezierPath *)toPath
                  duration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                   options:(LeoMaskAnimationOptions)options{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = toPath.CGPath;
    self.layer.mask = maskLayer;
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"path";
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.fromValue = (__bridge id)fromPath.CGPath;
    animation.toValue = (__bridge id)toPath.CGPath;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:[self mapOptionsToTimingFunction:options]];
    [maskLayer addAnimation:animation forKey:@"leoMaskAnimation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
}

-(void)leo_animateCircleMaskWithduration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                               clockwise:(BOOL)clockwise
                                 options:(LeoMaskAnimationOptions)options{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat maxSide = MAX(width, height);
    CGPoint center = CGPointMake(width/2, height/2);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:maxSide/2
                                                           startAngle:0.0
                                                             endAngle:M_PI * 2
                                                            clockwise:clockwise];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = bezierPath.CGPath;
    maskLayer.lineWidth = maxSide;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = [UIColor blackColor].CGColor;
    self.layer.mask = maskLayer;
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.beginTime = CACurrentMediaTime() + delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:[self mapOptionsToTimingFunction:options]];
    [maskLayer addAnimation:animation forKey:@"leoMaskAnimation"];
}

-(NSString *)mapOptionsToTimingFunction:(LeoMaskAnimationOptions)options{
    NSString * result = nil;
    if (options == LeoMaskAnimationOptionDefault) {
        result = kCAMediaTimingFunctionDefault;
    }else if (options  == LeoMaskAnimationOptionEaseIn){
        result  = kCAMediaTimingFunctionEaseIn;
    }else if(options == LeoMaskAnimationOptionEaseInOut){
        result = kCAMediaTimingFunctionEaseOut;
    }else if(options == LeoMaskAnimationOptionEaseOut){
        result = kCAMediaTimingFunctionEaseInEaseOut;
    }else if(options == LeoMaskAnimationOptionLiner){
        result = kCAMediaTimingFunctionLinear;
    }
    return result;
}

@end
