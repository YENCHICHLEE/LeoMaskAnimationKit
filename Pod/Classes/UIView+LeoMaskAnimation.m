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
                   options:(LeoMaskAnimationOptions)options
                   compeletion:(void(^)(void))completion
{
    UIBezierPath * fromPath = [UIBezierPath bezierPathWithRect:fromRect];
    UIBezierPath * toPath = [UIBezierPath bezierPathWithRect:toRect];
    [self leo_animateMaskFromPath:fromPath toPath:toPath duration:duration delay:delay options:options compeletion:completion];
}

-(void)leo_animateMaskFromPath:(UIBezierPath *)fromPath
                    toPath:(UIBezierPath *)toPath
                  duration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                   options:(LeoMaskAnimationOptions)options
                   compeletion:(void(^)(void))completion;
{
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = toPath.CGPath;
    self.layer.mask = maskLayer;
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"path";
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.fromValue = (__bridge id)fromPath.CGPath;
    animation.toValue = (__bridge id)toPath.CGPath;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:[self mapOptionsToTimingFunction:options]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:animation forKey:@"leoMaskAnimation"];
    [CATransaction commit];
}

-(void)leo_animateCircleMaskWithduration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                               clockwise:(BOOL)clockwise
                                 options:(LeoMaskAnimationOptions)options
                             compeletion:(void (^)(void))completion{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat maxSide = MAX(width, height);
    CGPoint center = CGPointMake(width/2, height/2);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:maxSide/2
                                                           startAngle:0.0
                                                             endAngle:M_PI * 2
                                                            clockwise:clockwise];
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
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
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:[self mapOptionsToTimingFunction:options]];
    [maskLayer addAnimation:animation forKey:@"leoMaskAnimation"];
    [CATransaction commit];
}
-(void)leo_animateCircleExpandFromView:(UIView *)fromView
                               duration:(NSTimeInterval)duration
                                  delay:(NSTimeInterval)delay
                                options:(LeoMaskAnimationOptions)options
                           compeletion:(void (^)(void))completion{
   
    CGFloat radius = [self leo_minSideOfView:fromView]/2;
    
    CGFloat width = CGRectGetHeight(self.bounds)/2;
    CGFloat height = CGRectGetWidth(self.bounds)/2;
    CGFloat toRadius = sqrt(pow(width, 2) + pow(height, 2));
    UIBezierPath * fromPath = [UIBezierPath bezierPathWithArcCenter:fromView.center
                                                             radius:radius
                                                         startAngle:0
                                                           endAngle:M_PI *2
                                                          clockwise:true];
    UIBezierPath * toPath = [UIBezierPath bezierPathWithArcCenter:fromView.center
                                                           radius:toRadius
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:true];
    [self leo_animateMaskFromPath:fromPath toPath:toPath duration:duration delay:delay options:options compeletion:completion];
}
-(void)leo_animateRectExpandDirection:(LeoMaskAnimationDirections)directions
                              duration:(NSTimeInterval)duration
                                 delay:(NSTimeInterval)delay
                               options:(LeoMaskAnimationOptions)options
                          compeletion:(void(^)(void))completion
{
    UIBezierPath * fromPath;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    if (directions == LeoMaskAnimationDirectionBottomToTop) {
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,height - 1, width, 1)];
    }else if(directions == LeoMaskAnimationDirectionLeftToRight){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, 1,height)];
    }else if(directions ==  LeoMaskAnimationDirectionTopToBottom){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, width, 1)];
    }else if(directions == LeoMaskAnimationDirectionRightToLeft){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(width - 1, 0, 1, height)];
    }else if(directions == LeoMaskAnimationDirectionLeftBottomToRightTop){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,height - 1, 1, 1)];
    }else if(directions == LeoMaskAnimationDirectionLeftTopToRightBottom){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, 1, 1)];
    }else if(directions == LeoMaskAnimationDirectionRightBottomToLeftTop){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(width - 1,height - 1, 1, 1)];
    }else if(directions  == LeoMaskAnimationDirectionRightTopToLeftBottom){
        fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(width - 1,0, 1, 1)];
    }else{
        return;
    }
    UIBezierPath * toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [self leo_animateMaskFromPath:fromPath toPath:toPath duration:duration delay:delay options:options compeletion:completion];
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
-(CGFloat)leo_minSideOfView:(UIView *)view{
    CGFloat width = CGRectGetWidth(view.bounds);
    CGFloat height = CGRectGetHeight(view.bounds);
    return MIN(width, height);
}
-(CGFloat)leo_maxSideOfView:(UIView *)view{
    CGFloat width = CGRectGetWidth(view.bounds);
    CGFloat height = CGRectGetHeight(view.bounds);
    return MAX(width, height);
}
@end
