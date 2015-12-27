//
//  LEOViewController.m
//  LeoMaskAnimationKit
//
//  Created by leoMobileDeveloper on 12/26/2015.
//  Copyright (c) 2015 leoMobileDeveloper. All rights reserved.
//

#import "LEOViewController.h"
#import "UIView+LeoMaskAnimation.h"
@interface LEOViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation LEOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.smallImageView.layer.cornerRadius = 50;
    self.smallImageView.layer.masksToBounds = true;
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)circleMask:(id)sender {
    [self.smallImageView leo_animateCircleMaskWithduration:2.0
                                                     delay:0.0
                                                 clockwise:true
                                                   options:LeoMaskAnimationOptionDefault];
}
- (IBAction)rectMask:(id)sender {
//    [self.containView leo_animateMaskFromRect:self.smallImageView.frame
//                                               toRect:self.containView.bounds
//                                             duration:2.0
//                                                delay:0.0
//                                              options:LeoMaskAnimationOptionDefault];
 [self.containView leo_animateCircleExpandFromView:self.smallImageView
                                          duration:2.0
                                             delay:0.0
                                           options:LeoMaskAnimationOptionEaseInOut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
