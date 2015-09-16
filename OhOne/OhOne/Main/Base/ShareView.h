//
//  ShareView.h
//  OhOne
//
//  Created by 弄潮者 on 15/8/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneButton.h"

@interface ShareView : UIView

@property (nonatomic,strong) UILabel *shareLabel;

@property (nonatomic,strong) OneButton *sinaShareButton;

@property (nonatomic,strong) OneButton *wechatShareButton;

@property (nonatomic,strong) OneButton *renrenShareButton;

@property (nonatomic,strong) OneButton *tencentShareButton;

@property (nonatomic,strong) OneButton *collectButton;

@property (nonatomic,strong) OneButton *saveImageButton;

@property (nonatomic,strong) OneButton *modeButton;

@property (nonatomic,strong) OneButton *fontButton;

//type为0 编辑按钮为文字页面按钮 收藏、夜间模式、显示设置
//type为1 编辑按钮为图片页面按钮 收藏、保存图片、夜间模式
- (instancetype)initWithFrame:(CGRect)frame Type:(NSInteger)type;

@end
