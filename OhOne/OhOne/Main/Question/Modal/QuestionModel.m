//
//  QuestionModel.m
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",_strLastUpdateDate,_strDayDiffer,_sWebLk,_strPraiseNumber,_strQuestionId,_strQuestionTitle,_strAnswerContent,_strAnswerTitle,_strAnswerContent,_strQuestionMarketTime,_sEditor];
}


@end
