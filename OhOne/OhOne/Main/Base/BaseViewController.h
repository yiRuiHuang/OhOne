//
//  BaseViewController.h
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareView.h"

@interface BaseViewController : UIViewController


@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIControl *coverView;
@property (nonatomic, strong) ShareView *shareView;


- (void)coverTapAction:(UIControl *)control;

@end
