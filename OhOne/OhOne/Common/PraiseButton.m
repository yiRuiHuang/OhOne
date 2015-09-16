//
//  PraiseButton.m
//  OhOne
//
//  Created by hyrMac on 15/8/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PraiseButton.h"

@implementation PraiseButton
//    PraiseButton示例
//    PraiseButton *button = [[PraiseButton alloc] initWithFrame:CGRectMake(40, 250, 90, 20)];
//    [button setTitle:@"1323" forState:UIControlStateNormal];
//    [self.view addSubview:button];



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 正常图片
        [self setImage:[UIImage imageNamed:@"home_like@3x.png"] forState:UIControlStateNormal];
        
        // 选中图片
        [self setImage:[UIImage imageNamed:@"home_like_hl@3x.png"] forState:UIControlStateSelected];
        
        // 背景图片 根据button大小来拉伸背景图片
        UIImage *bgImg = [UIImage imageNamed:@"home_likeBg@3x.png"];
        bgImg = [bgImg stretchableImageWithLeftCapWidth:self.frame.size.width/2-5 topCapHeight:self.frame.size.height/2-5];
        [self setBackgroundImage:bgImg forState:UIControlStateNormal];
        
        // 字体颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    [self setImage:[UIImage imageNamed:@"home_like@3x.png"] forState:UIControlStateNormal];
    
    // 选中图片
    [self setImage:[UIImage imageNamed:@"home_like_hl@3x.png"] forState:UIControlStateSelected];
    
    // 背景图片 根据button大小来拉伸背景图片
    UIImage *bgImg = [UIImage imageNamed:@"home_likeBg@3x.png"];
    bgImg = [bgImg stretchableImageWithLeftCapWidth:self.frame.size.width/2-5 topCapHeight:self.frame.size.height/2-5];
    [self setBackgroundImage:bgImg forState:UIControlStateNormal];
    
    // 字体颜色
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}


@end
