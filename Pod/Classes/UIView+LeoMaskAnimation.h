//
//  UIView+LeoMaskAnimation.h
//  LeoMaskAnimationKit
//
//  Created by huangwenchen on 15/12/26.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LeoMaskAnimationOptions){
    LeoMaskAnimationOptionLiner,
    LeoMaskAnimationOptionEaseIn,
    LeoMaskAnimationOptionEaseOut,
    LeoMaskAnimationOptionEaseInOut,
    LeoMaskAnimationOptionDefault,
};
@interface UIView (LeoMaskAnimation)

-(void)leo_animateMaskFromRect:(CGRect)fromRect
                    toRect:(CGRect)toRect
                  duration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                       options:(LeoMaskAnimationOptions)options;

-(void)leo_animateMaskFromPath:(UIBezierPath *)fromPath
                    toPath:(UIBezierPath *)toPath
                  duration:(NSTimeInterval)duration
                     delay:(NSTimeInterval)delay
                       options:(LeoMaskAnimationOptions)options;

-(void)leo_animateCircleMaskWithduration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                               clockwise:(BOOL)clockwise
                                 options:(LeoMaskAnimationOptions)options;

-(void)leo_animateCircleExpandFromView:(UIView *)fromView
                      duration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                       options:(LeoMaskAnimationOptions)options;
@end
