//
//  ArticleView.m
//  OhOne
//
//  Created by hyrMac on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ArticleView.h"
#import "ArticleModel.h"
#import "PraiseButton.h"
#import "CountStrHeight.h"

@implementation ArticleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _createSubs];
    }
    return self;
}

- (void)setModel:(ArticleModel *)model {
    if (model != _model) {
        _model = model;
        [self setNeedsLayout];
    }
   
}


- (void)_createSubs {
    
    _homeBgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_homeBgScrollView];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [_homeBgScrollView addSubview:_containerView];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:self.dateLabel];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:self.titleLabel];
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:self.authorLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.numberOfLines = 0;
    [_containerView addSubview:_contentLabel];

    self.editerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:self.editerLabel];
    
    self.loveButton = [[PraiseButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [_containerView addSubview:self.loveButton];
//    _strPnButton.frame = CGRectMake(kWidth-80, 0, 90, 30);
//    _strPnButton.top = _contentLabelBg.bottom + 30;
//    [_strPnButton setTitle:_model.strPn forState:UIControlStateNormal];
    
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.lineImageView.image = [UIImage imageNamed:@"que_line"];
    [_containerView addSubview:self.lineImageView];

    self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:self.authorNameLabel];

//    self.weiboNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    [self addSubview:self.weiboNameLabel];

    _detailAuthorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_containerView addSubview:_detailAuthorLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // 日期
    NSArray *dateArray = [_model.strContMarketTime componentsSeparatedByString:@"-"];
    NSDictionary *dataChange = @{@"01":@"January",  @"02":@"February",
                                 @"03":@"March",    @"04":@"April",
                                 @"05":@"May",      @"06":@"June",
                                 @"07":@"July",     @"08":@"August",
                                 @"09":@"September",@"10":@"October",
                                 @"11":@"November", @"12":@"December"};
    self.dateLabel.frame = CGRectMake(10, 20, kWidth, 20);
    _dateLabel.font = [UIFont systemFontOfSize:16];
    _dateLabel.textColor = [UIColor darkGrayColor];
    _dateLabel.text = [NSString stringWithFormat:@"%@ %@, %@",dataChange[dateArray[1]],dateArray[2],dateArray[0]];
    
    // 文章标题
    self.titleLabel.frame = CGRectMake(10, 50, kWidth, 30);
    _titleLabel.font = [UIFont boldSystemFontOfSize:22];
    _titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.text = self.model.strContTitle;
    
    
    // 作者
    self.authorLabel.frame = CGRectMake(10, 90, kWidth, 10);
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textColor = [UIColor darkGrayColor];
    self.authorLabel.text = self.model.strContAuthor;
    
    
    // 文章内容
    _model.strContent = [_model.strContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
    self.contentLabel.text = self.model.strContent;
    _contentLabel.text = _model.strContent;

    CGFloat strContentHeight = [CountStrHeight countHeightForStr:self.model.strContent FontType:[UIFont systemFontOfSize:13] RowWidth:kWidth-20];
    
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textColor = [UIColor darkGrayColor];
    [_contentLabel sizeToFit];
    _contentLabel.backgroundColor = [UIColor clearColor];
    
    CGRect contentStrFrame = _contentLabel.frame;
    contentStrFrame = CGRectMake(10, 120, kWidth-20, strContentHeight);
    _contentLabel.frame = contentStrFrame;
    
    
    // 编辑
    self.editerLabel.text = self.model.strContAuthorIntroduce;
    self.editerLabel.frame = CGRectMake(10, _contentLabel.bottom+20, kWidth-20, 20);
    _editerLabel.font = [UIFont italicSystemFontOfSize:16];  // 斜体
    _editerLabel.textColor = [UIColor darkGrayColor];
    self.editerLabel.text = self.model.strContAuthorIntroduce;
    
    // 点赞按钮
    _loveButton.frame = CGRectMake(kWidth-80, 0, 80, 30);
    _loveButton.top = _editerLabel.bottom + 20;
    [_loveButton setTitle:_model.strPraiseNumber forState:UIControlStateNormal];
    
    // 分割线
    CGFloat lineHeight = _loveButton.bottom + 20;
    self.lineImageView.frame = CGRectMake(10, lineHeight, kWidth-20, 2);

    
    //作者名字 + 作者微博
    self.authorNameLabel.text = [_model.strContAuthor stringByAppendingString:_model.sWbN];
    self.authorNameLabel.frame = CGRectMake(10, _lineImageView.bottom +15, kWidth, 30);
    self.authorNameLabel.font = [UIFont systemFontOfSize:20];
    self.authorNameLabel.textColor = [UIColor darkGrayColor];
//    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:_model.strContAuthor];
//    [attrString addAttribute:NSFontAttributeName
//                       value:[UIFont boldSystemFontOfSize:15]
//                       range:NSMakeRange(0, _model.strContAuthor.length)];
//    self.authorNameLabel.attributedText = attrString;
    
    
    //作者介绍
    self.detailAuthorLabel.text = self.model.sAuth;
    CGFloat detailAuthorHeight = [CountStrHeight countHeightForStr:self.model.sAuth FontType:[UIFont systemFontOfSize:20] RowWidth:kWidth-20];
    self.detailAuthorLabel.frame = CGRectMake(10, _authorNameLabel.bottom +20, kWidth-20, detailAuthorHeight+10);
    self.detailAuthorLabel.font = [UIFont systemFontOfSize:16];
    self.detailAuthorLabel.textColor = [UIColor darkGrayColor];
    _detailAuthorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _detailAuthorLabel.numberOfLines = 0;
    [_detailAuthorLabel sizeToFit];
    _detailAuthorLabel.backgroundColor = [UIColor clearColor];
    
    
    

//    self.frame = CGRectMake(0,0, kWidth, kHeight-49-64);
//    self.contentSize = CGSizeMake(kWidth, _detailAuthorLabel.bottom+30);
    
    //    容器视图
    _containerView.frame = CGRectMake(0, 0, kWidth, _detailAuthorLabel.bottom+30);
    
    
    _homeBgScrollView.contentSize = CGSizeMake(kWidth, _detailAuthorLabel.bottom+30);


}



@end
