//
//  HomeView.h
//  OhOne
//
//  Created by hyrMac on 15/8/31.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@class PraiseButton;
@class ZoomImageView;
@interface HomeView : UIView
/**
 strHpTitle	        String		期刊号
 strThumbnailUrl	String		中间配图的缩略图
 strOriginalImgUrl	String		原图，点击放大时的图片
 strAuthor	        String		作品名称和作者（显示时还要解析，根据“&”）
 strMarketTime	    String		发表日期（即今天)
 strContent         String		鸡汤正文
 wImgUrl            String		首页整体效果图，好像没啥卵用
 strPn              String		当前点赞数
 */
@property (strong, nonatomic)  UIImageView *contentLabelBg;
@property (strong, nonatomic)  UIView *containerView;

@property (strong, nonatomic)  UIScrollView *homeBgScrollView;
@property (strong, nonatomic)  UILabel *strHpTitleLabel;
@property (strong, nonatomic)  ZoomImageView *strThumbnailUrlImageView;
@property (strong, nonatomic)  UILabel *opusLabel;
@property (strong, nonatomic)  UILabel *authorLabel;
@property (strong, nonatomic)  UILabel *dayLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *strContentLabel;
@property (strong, nonatomic)  PraiseButton *strPnButton;



@property (nonatomic, strong) HomeModel *model;
@end
