//
//  HomeView.m
//  OhOne
//
//  Created by hyrMac on 15/8/31.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "HomeView.h"
#import "HomeModel.h"
#import "UIImageView+WebCache.h"
#import "PraiseButton.h"
#import "UIViewExt.h"
#import "Utils.h"
#import "ZoomImageView.h"

@implementation HomeView

- (void)setModel:(HomeModel *)model {
    _model = model;
    [self setNeedsLayout];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubs];
    }
    return self;
}


- (void)_createSubs {
    
    
    _homeBgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_homeBgScrollView];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [_homeBgScrollView addSubview:_containerView];
    
    _strHpTitleLabel = [[UILabel alloc] init];
    [_containerView addSubview:_strHpTitleLabel];
    
    _strThumbnailUrlImageView = [[ZoomImageView alloc] init];
    [_containerView addSubview:_strThumbnailUrlImageView];
    
//    作品名称
    _opusLabel = [[UILabel alloc] init];
    [_containerView addSubview:_opusLabel];
    
    _authorLabel = [[UILabel alloc] init];
    [_containerView addSubview:_authorLabel];
    
    _dayLabel = [[UILabel alloc] init];
    [_containerView addSubview:_dayLabel];
    
    _timeLabel = [[UILabel alloc] init];
    [_containerView addSubview:_timeLabel];
    
    
    _contentLabelBg = [[UIImageView alloc] init];
    [_containerView addSubview:_contentLabelBg];
    
    
    _strContentLabel = [[UILabel alloc] init];
    [_containerView addSubview:_strContentLabel];
    
    
    _strPnButton = [[PraiseButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [_containerView addSubview:_strPnButton];
    
    
}
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 背景滑动视图
    _homeBgScrollView.scrollEnabled = YES;
    _homeBgScrollView.backgroundColor = [UIColor whiteColor];
    
    
    
    //    期刊号
    _strHpTitleLabel.text = _model.strHpTitle;
    _strHpTitleLabel.backgroundColor = [UIColor clearColor];
    _strHpTitleLabel.frame = CGRectMake(8, 8, kWidth-8, 21);
    

    
    //    中间配图的缩略图
    NSString *strThumbnailUrlStr = _model.strThumbnailUrl;
    _strThumbnailUrlImageView.frame = CGRectMake(8, 37, kWidth-16, 235);
    [_strThumbnailUrlImageView sd_setImageWithURL:[NSURL URLWithString:strThumbnailUrlStr]];
    _strThumbnailUrlImageView.contentMode = UIViewContentModeScaleToFill;
    
    
    //    作品名称和作品
    NSArray *workArray = [_model.strAuthor componentsSeparatedByString:@"&"];
    
    _opusLabel.text = workArray[0];
    _opusLabel.font = [UIFont systemFontOfSize:14];
    _opusLabel.textAlignment = NSTextAlignmentRight;
    _opusLabel.textColor = [UIColor darkGrayColor];
    _opusLabel.backgroundColor = [UIColor clearColor];
    _opusLabel.frame = CGRectMake(0, 280, kWidth-8, 21);
    
    _authorLabel.text = workArray[1];
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textColor = [UIColor darkGrayColor];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    _authorLabel.backgroundColor = [UIColor clearColor];
    _authorLabel.frame = CGRectMake(0, 305, kWidth-8, 21);
    
    //    鸡汤
    CGFloat maxLabelWidth = kWidth-78-15;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize contentSize = [_model.strContent boundingRectWithSize:CGSizeMake(maxLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGFloat height =  contentSize.height+20;
    
    _contentLabelBg.frame = CGRectMake(78, 388, maxLabelWidth, 0);
    _contentLabelBg.height = height;
    _strContentLabel.text = _model.strContent;
    _strContentLabel.textColor = [UIColor whiteColor];
    _strContentLabel.font = [UIFont systemFontOfSize:14];
    _strContentLabel.numberOfLines = 0;
    _strContentLabel.backgroundColor = [UIColor clearColor];
    _strContentLabel.frame = _contentLabelBg.frame;
    _strContentLabel.width = _strContentLabel.width-15;
    _strContentLabel.center = _contentLabelBg.center;
    
    UIImage *contentImg = [UIImage imageNamed:@"contBack@2x.png"];
    contentImg = [contentImg stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_contentLabelBg setImage:contentImg];
    
    
    
    
    //    2015-08-28           55 195 242
    //    NSLog(@"%@",_model.strMarketTime);
    NSString *newDateStr = [Utils oneString:_model.strMarketTime];
    //    NSLog(@"%@",newDateStr);
    
    NSArray *dateArray = [newDateStr componentsSeparatedByString:@"-"];
    
    _dayLabel.text = [dateArray lastObject];
    _dayLabel.frame = CGRectMake(24, 388, 46, 40);
    _dayLabel.font = [UIFont boldSystemFontOfSize:30];
    _dayLabel.textColor = [UIColor colorWithRed:55/255.0 green:195/255.0 blue:242/255.0 alpha:0.9];
    _dayLabel.backgroundColor = [UIColor clearColor];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@,%@",dateArray[1],dateArray[0]];
    _timeLabel.frame = CGRectMake(24, 426, 46, 21);
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.backgroundColor = [UIColor clearColor];
    
    
    
    
    //    点赞按钮
    _strPnButton.frame = CGRectMake(kWidth-80, 0, 90, 30);
    _strPnButton.top = _contentLabelBg.bottom + 30;
    [_strPnButton setTitle:_model.strPn forState:UIControlStateNormal];
    
    
    //    容器视图
    _containerView.frame = CGRectMake(0, 0, kWidth, height+554-69);
    
    
    _homeBgScrollView.contentSize = CGSizeMake(kWidth, height+554-69);
    
    
}


@end
