//
//  ArticleModel.h
//  OhOne
//
//  Created by hyrMac on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic) NSString *strContMarketTime;                //日期
@property (nonatomic) NSString *strContTitle;                     //文章标题
@property (nonatomic) NSString *strContAuthor;                    //作者
@property (nonatomic) NSString *strContent;                       //文章
@property (nonatomic) NSString *strContAuthorIntroduce;           //责任编辑
@property (nonatomic) NSString *strPraiseNumber;                  //点赞数
//@property (nonatomic) NSString *strAuthorN;
@property (nonatomic) NSString *sWbN;                             //微博名字
@property (nonatomic) NSString *sAuth;                            //作家介绍

@end
