//
//  HomeModel.h
//  OhOne
//
//  Created by hyrMac on 15/8/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject


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


@property (nonatomic, copy) NSString *strHpTitle;
@property (nonatomic, copy) NSString *strThumbnailUrl;
@property (nonatomic, copy) NSString *strOriginalImgUrl;
@property (nonatomic, copy) NSString *strAuthor;
@property (nonatomic, copy) NSString *strMarketTime;
@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) NSString *wImgUrl;
@property (nonatomic, copy) NSString *strPn;


@end
