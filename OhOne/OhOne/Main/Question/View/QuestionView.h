//
//  QuestionView.h
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"
#import "PraiseButton.h"

@interface QuestionView : UIView

@property (nonatomic,strong) QuestionModel *model;

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView        *containerView;
@property (nonatomic, strong) UILabel       *dateLabel;

@property (nonatomic, strong) UIImageView   *questionImageView;
@property (nonatomic, strong) UILabel       *questionTitleLabel;
@property (nonatomic, strong) UILabel       *questionContentLabel;

@property (nonatomic, strong) UIImageView   *lineBreakImageView;

@property (nonatomic, strong) UIImageView   *answerImageView;
@property (nonatomic, strong) UILabel       *answerTitleLabel;
@property (nonatomic, strong) UILabel       *answerContentLabel;

@property (nonatomic, strong) UILabel       *editorLabel;
@property (strong, nonatomic)  PraiseButton *strPnButton;

@end
