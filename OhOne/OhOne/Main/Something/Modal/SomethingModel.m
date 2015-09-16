//
//  SomethingModel.m
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "SomethingModel.h"

@implementation SomethingModel

- (NSString *)description {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",self.strLastUpdateDate,self.strPn,self.strBu,self.strTm,self.strWu,self.strId,self.strTt,self.strTc];
}

@end
