//
//  QuestionView.m
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "QuestionView.h"
#import "UIViewExt.h"

@implementation QuestionView

- (void)setModel:(QuestionModel *)model {
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
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [_scrollView addSubview:_containerView];
    
    _dateLabel = [[UILabel alloc] init];
    [_containerView addSubview:_dateLabel];
    
    _questionImageView = [[UIImageView alloc] init];
    _questionImageView.image = [UIImage imageNamed:@"que_img.png"];
    [_containerView addSubview:_questionImageView];

    _questionTitleLabel = [[UILabel alloc] init];
    [_containerView addSubview:_questionTitleLabel];
    
    _questionContentLabel = [[UILabel alloc] init];
    [_containerView addSubview:_questionContentLabel];
    
    _lineBreakImageView = [[UIImageView alloc] init];
    _lineBreakImageView.image = [UIImage imageNamed:@"que_line.png"];
    [_containerView addSubview:_lineBreakImageView];
    
    _answerImageView = [[UIImageView alloc] init];
    _answerImageView.image = [UIImage imageNamed:@"ans_img.png"];
    [_containerView addSubview:_answerImageView];
    
    _answerTitleLabel = [[UILabel alloc] init];
    [_containerView addSubview:_answerTitleLabel];
    
    _answerContentLabel = [[UILabel alloc] init];
    [_containerView addSubview:_answerContentLabel];
    
    _editorLabel = [[UILabel alloc] init];
    [_containerView addSubview:_editorLabel];
    
    _strPnButton = [[PraiseButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [_containerView addSubview:_strPnButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 背景滑动视图
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *dateArray = [_model.strQuestionMarketTime componentsSeparatedByString:@"-"];
//    NSLog(@"dateArray : %@",dateArray);
    NSDictionary *dataChange = @{@"01":@"January",  @"02":@"February",
                                 @"03":@"March",    @"04":@"April",
                                 @"05":@"May",      @"06":@"June",
                                 @"07":@"July",     @"08":@"August",
                                 @"09":@"September",@"10":@"October",
                                 @"11":@"November", @"12":@"December"};
//    NSLog(@"%@",dataChange[dateArray[1]]);
    _dateLabel.frame = CGRectMake(15, 15, kWidth-8, 30);
    _dateLabel.font = [UIFont boldSystemFontOfSize:16];
    _dateLabel.textColor = [UIColor darkGrayColor];
    _dateLabel.text = [NSString stringWithFormat:@"%@ %@, %@",dataChange[dateArray[1]],dateArray[2],dateArray[0]];
    
    
    _questionImageView.frame = CGRectMake(30, 60, 50 , 50);

    //问题
    CGFloat maxTitleLabelWidth = kWidth-105;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGSize questionTitleContentSize = [_model.strQuestionTitle boundingRectWithSize:CGSizeMake(maxTitleLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGFloat questionTitleheight =  questionTitleContentSize.height+5;

    _questionTitleLabel.frame = CGRectMake(90, 65, maxTitleLabelWidth, questionTitleheight);
    _questionTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    _questionTitleLabel.textColor = [UIColor darkGrayColor];
    _questionTitleLabel.numberOfLines = 0;
    _questionTitleLabel.text = _model.strQuestionTitle;
    
    //问题描述
    CGFloat maxContentLabelWidth = kWidth-30;
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize questionContentContentSize = [_model.strQuestionContent boundingRectWithSize:CGSizeMake(maxContentLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil].size;
    CGFloat questionContentheight =  questionContentContentSize.height+5;
    
    _questionContentLabel.frame = CGRectMake(20, _questionTitleLabel.bottom+30, maxContentLabelWidth, questionContentheight);
    _questionContentLabel.font = [UIFont systemFontOfSize:16];
    _questionContentLabel.textColor = [UIColor darkGrayColor];
    _questionContentLabel.numberOfLines = 0;
    _questionContentLabel.text = _model.strQuestionContent;
    
    //分隔线
    _lineBreakImageView.frame = CGRectMake(20, _questionContentLabel.bottom+15, kWidth-40, 2);
    
    //回答图片
    _answerImageView.frame = CGRectMake(30, _lineBreakImageView.bottom+15, 50 , 50);

    //回答标题
    CGSize answerTitleContentSize = [_model.strAnswerTitle boundingRectWithSize:CGSizeMake(maxTitleLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGFloat answerTitleheight =  answerTitleContentSize.height+5;
    
    _answerTitleLabel.frame = CGRectMake(90, _lineBreakImageView.bottom+25, maxTitleLabelWidth, answerTitleheight);
    _answerTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    _answerTitleLabel.textColor = [UIColor darkGrayColor];
    _answerTitleLabel.numberOfLines = 0;
    _answerTitleLabel.text = _model.strAnswerTitle;
    
    //回答正文
    _model.strAnswerContent = [_model.strAnswerContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
    
    CGSize answerContentContentSize = [_model.strAnswerContent boundingRectWithSize:CGSizeMake(maxContentLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil].size;
    CGFloat answerContentheight =  answerContentContentSize.height+5;
    
    _answerContentLabel.frame = CGRectMake(20, _answerTitleLabel.bottom+30, maxContentLabelWidth, answerContentheight);
    _answerContentLabel.font = [UIFont systemFontOfSize:16];
    _answerContentLabel.textColor = [UIColor darkGrayColor];
    _answerContentLabel.numberOfLines = 0;
    _answerContentLabel.text = _model.strAnswerContent;

    
    //editor
    _editorLabel.frame = CGRectMake(20, _answerContentLabel.bottom+10, kWidth-20, 30);
#warning 斜体设置，为什么没有效果
    _editorLabel.font = [UIFont italicSystemFontOfSize:16];
    _editorLabel.textColor = [UIColor darkGrayColor];
    _editorLabel.text = _model.sEditor;
    
    //点赞
    _strPnButton.frame = CGRectMake(kWidth-80, _editorLabel.bottom, 90, 30);
    _strPnButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _strPnButton.titleLabel.textColor = [UIColor darkGrayColor];
    [_strPnButton setTitle:[NSString stringWithFormat:@" %@",_model.strPraiseNumber] forState:UIControlStateNormal];
    //
    //    @property (nonatomic, strong) UILabel       *editorLabel;
    //    @property (strong, nonatomic)  PraiseButton *strPnButton;
    
    
    
    
    _containerView.frame = CGRectMake(0, 0, kWidth, questionTitleheight+questionContentheight+answerTitleheight+answerContentheight+258);
    _scrollView.contentSize = CGSizeMake(kWidth,questionTitleheight+questionContentheight+answerTitleheight+answerContentheight+258);
    
}


@end
