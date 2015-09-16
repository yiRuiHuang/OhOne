//
//  ArticleView.h
//  OhOne
//
//  Created by hyrMac on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleModel;
@class PraiseButton;

@interface ArticleView : UIView

@property (strong, nonatomic)  UIView *containerView;

@property (strong, nonatomic)  UIScrollView *homeBgScrollView;

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UILabel *editerLabel;
@property (nonatomic) PraiseButton *loveButton;

@property (nonatomic) UIImageView *lineImageView;
@property (nonatomic) UILabel *authorNameLabel;
//@property (nonatomic) UILabel *weiboNameLabel;
@property (nonatomic) UILabel *detailAuthorLabel;


@property (nonatomic) ArticleModel *model;

@end
