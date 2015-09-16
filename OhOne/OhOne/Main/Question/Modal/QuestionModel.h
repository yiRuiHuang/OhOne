//
//  QuestionModel.h
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
//strLastUpdateDate     : "2015-09-04 21:21:43"
//strDayDiffer          : "1"
//sWebLk                : "http:\/\/m.wufazhuce.com\/question\/2015-09-04"
//strPraiseNumber       : "7356"
//strQuestionId         : "1092"
//strQuestionTitle      : "什么事情让你觉得自己从男孩突然变成了男人？"
//strQuestionContent    : "豆子魔法问：什么事情让你觉得自己从男孩突然变成了男人？"
//strAnswerTitle        : "张佳玮答豆子魔法："
//strAnswerContent      : "……"
//strQuestionMarketTime : "2015-09-04"
//sEditor               : "(责任编辑：好谢翔）"

@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *strDayDiffer;
@property (nonatomic, copy) NSString *sWebLk;
@property (nonatomic, copy) NSString *strPraiseNumber;
@property (nonatomic, copy) NSString *strQuestionId;
@property (nonatomic, copy) NSString *strQuestionTitle;
@property (nonatomic, copy) NSString *strQuestionContent;
@property (nonatomic, copy) NSString *strAnswerTitle;
@property (nonatomic, copy) NSString *strAnswerContent;
@property (nonatomic, copy) NSString *strQuestionMarketTime;
@property (nonatomic, copy) NSString *sEditor;

@end
