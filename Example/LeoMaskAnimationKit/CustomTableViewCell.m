//
//  CustomTableViewCell.m
//  LeoMaskAnimationKit
//
//  Created by huangwenchen on 16/1/4.
//  Copyright © 2016年 leoMobileDeveloper. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UIView+LeoMaskAnimation.h"
@interface CustomTableViewCell ()

@property (strong,nonatomic)UIView * maskbackgroundView;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    UIView * toMaskView = [self subviews].firstObject;
    [toMaskView leo_removeMaskAnimations];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint touchPoint = [[touches anyObject] locationInView:self.contentView];
    UIView * toMaskView = [self subviews].firstObject;
    [toMaskView leo_animateCircleExpandCenter:touchPoint
                                   radius:2.0
                                 duration:0.8
                                    delay:0.0
                                    alpha:1.0
                                  options:LeoMaskAnimationOptionEaseInOut
                              compeletion:nil];
}
@end
