//
//  ShareView.m
//  OhOne
//
//  Created by 弄潮者 on 15/8/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame Type:(NSInteger)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self _creatSubViews];
        if (type == 1) {
            [self _creatEditImageButton];
        }else {
            [self _creatEditWordButton];
        }
    }
    return self;
}

- (void)_creatSubViews {
    self.backgroundColor = [UIColor greenColor];
    
    _shareLabel = [[UILabel alloc] initWithFrame:CGRectMake((kWidth-100)/2, 0, 100, 50)];
    _shareLabel.text = @"分享到";
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_shareLabel];
    
    [self _creatShareButton];
    
}

- (void)_creatShareButton {
    CGFloat shareBtnWidth = kWidth/4;
    CGFloat shareBtnHeight = 70;
    
    _sinaShareButton = [[OneButton alloc] initWithFrame:CGRectMake(0, 50, shareBtnWidth, shareBtnHeight)
                                          withImageName:@"share_sina"
                                              withTitle:@"新浪微博"];
    [_sinaShareButton setBackgroundColor:[UIColor whiteColor]];
    
    _wechatShareButton = [[OneButton alloc] initWithFrame:CGRectMake(shareBtnWidth, 50, shareBtnWidth, shareBtnHeight)
                                            withImageName:@"share_timeline"
                                                withTitle:@"微信朋友圈"];
    [_sinaShareButton setBackgroundColor:[UIColor whiteColor]];
    
    _renrenShareButton = [[OneButton alloc] initWithFrame:CGRectMake(shareBtnWidth*2, 50, shareBtnWidth, shareBtnHeight)
                                            withImageName:@"share_renn"
                                                withTitle:@"人人"];
    [_sinaShareButton setBackgroundColor:[UIColor whiteColor]];
    
    _tencentShareButton = [[OneButton alloc] initWithFrame:CGRectMake(shareBtnWidth*3, 50, shareBtnWidth, shareBtnHeight)
                                             withImageName:@"share_tc"
                                                 withTitle:@"腾讯微博"];
    [_sinaShareButton setBackgroundColor:[UIColor whiteColor]];
    
    
    [self addSubview:_sinaShareButton];
    [self addSubview:_wechatShareButton];
    [self addSubview:_renrenShareButton];
    [self addSubview:_tencentShareButton];
}

- (void)_creatEditImageButton {
    CGFloat shareBtnWidth = (kWidth-120)/3;
    CGFloat shareBtnHeight = 70;
    
    _collectButton = [[OneButton alloc] initWithFrame:CGRectMake(60, 140, shareBtnWidth, shareBtnHeight)
                                          withImageName:@"share_col"
                                              withTitle:@"加入收藏"];
    [_collectButton setBackgroundColor:[UIColor whiteColor]];
    
    _saveImageButton = [[OneButton alloc] initWithFrame:CGRectMake(60+shareBtnWidth, 140, shareBtnWidth, shareBtnHeight)
                                        withImageName:@"share_save"
                                            withTitle:@"保存图片"];
    [_saveImageButton setBackgroundColor:[UIColor whiteColor]];
    
    _modeButton = [[OneButton alloc] initWithFrame:CGRectMake(60+shareBtnWidth*2, 140, shareBtnWidth, shareBtnHeight)
                                          withImageName:@"share_night"
                                              withTitle:@"夜间模式"];
    [_modeButton setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_collectButton];
    [self addSubview:_saveImageButton];
    [self addSubview:_modeButton];
}

- (void)_creatEditWordButton {
    CGFloat shareBtnWidth = (kWidth-120)/3;
    CGFloat shareBtnHeight = 70;
    
    _collectButton = [[OneButton alloc] initWithFrame:CGRectMake(60, 140, shareBtnWidth, shareBtnHeight)
                                        withImageName:@"share_col"
                                            withTitle:@"加入收藏"];
    [_collectButton setBackgroundColor:[UIColor whiteColor]];
    
    _saveImageButton = [[OneButton alloc] initWithFrame:CGRectMake(60+shareBtnWidth, 140, shareBtnWidth, shareBtnHeight)
                                          withImageName:@"share_night"
                                              withTitle:@"夜间模式"];
    [_saveImageButton setBackgroundColor:[UIColor whiteColor]];
    
    _fontButton = [[OneButton alloc] initWithFrame:CGRectMake(60+shareBtnWidth*2, 140, shareBtnWidth, shareBtnHeight)
                                     withImageName:@"share_font@2x"
                                         withTitle:@"显示设置"];
    [_fontButton setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_collectButton];
    [self addSubview:_saveImageButton];
    [self addSubview:_fontButton];
}

@end
