//
//  Utils.h
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSDate *)dateFromString:(NSString *)dateStr withFormatterStr:(NSString *)formatterStr;

+ (NSString *)stringFromDate:(NSDate *)date withFormatterStr:(NSString *)formatterStr;

//+ (NSString *)weiboString:(NSString *)dateStr;

+ (NSString *)oneString:(NSString *)dateStr;

@end
