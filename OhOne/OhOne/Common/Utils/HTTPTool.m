//
//  HTTPTool.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "HTTPTool.h"

// 1天的长度
static const NSTimeInterval oneDay = 24 * 60 * 60;


@implementation HTTPTool 

+ (AFHTTPRequestOperationManager *)initAFHttpManager {
	static AFHTTPRequestOperationManager *manager;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		manager = [[AFHTTPRequestOperationManager alloc] init];
		manager.responseSerializer = [AFJSONResponseSerializer serializer];
		manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
		manager.operationQueue.maxConcurrentOperationCount = 1;
	});
	
	return manager;
}

+ (NSDictionary *)parametersWithIndex:(NSInteger)index {
	if (index > 9) {
		NSString *date = [self stringDateBeforeTodaySeveralDays:index];
		NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
		
		return parameters;
	} else {
		NSString *date = [self stringDateFromCurrent];
		NSDictionary *parameters = @{@"strDate" : date, @"strRow" : [@(++index) stringValue]};
		
		return parameters;
	}
}

/**
 *  获取首页数据
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestHomeContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : [@1 stringValue]};
	[manager GET:URL_GET_HOME_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

/**
 *  获取首页数据
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestHomeContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = [self parametersWithIndex:index];
	[manager GET:URL_GET_HOME_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
		fail(operation,error);
	}];
}

/**
 *  获取文章
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式或者也可以是"yyyy-MM-dd HH:mm:ss"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestReadingContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
	[manager GET:URL_GET_READING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

//+ (void)requestReadingContentByIndex:(NSInteger)index lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
//	[manager GET:URL_GET_READING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

/**
 *   获取问题
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestQuestionContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
	[manager GET:URL_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

//+ (void)requestQuestionContentByIndex:(NSInteger)index lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
//	[manager GET:URL_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

//+ (void)requestQuestionContentBackupByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
//	[manager GET:URL_BACKUP_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

/**
 *  获取东西
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestThingContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
	[manager GET:URL_GET_THING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

/**
 *  获取东西
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestThingContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = [self parametersWithIndex:index];
	[manager GET:URL_GET_THING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}



#pragma mark - 获取今天之前的相应天数的日期
/**
 *  获取今天之前的相应天数的日期
 *
 *  @param days 几天之前
 *
 *  @return 相应天数之前的那天的日期
 */
+ (NSString *)stringDateBeforeTodaySeveralDays:(NSInteger)days {
    NSString *stringDate = @"";
    
    NSDate *now = [NSDate date];
    NSDate *theDate;
    
    if (days != 0) {
        theDate = [now initWithTimeIntervalSinceNow:(-oneDay * days)];
    } else {
        theDate = now;
    }
    
    stringDate = [self stringDateFromDate:theDate];
    
    return stringDate;
}

+ (NSString *)stringDateFromDate:(NSDate *)date {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateformatter stringFromDate:date];
    
    return dateString;
}

// 将当前时间转成字符串，格式：yyyy-MM-dd
+ (NSString *)stringDateFromCurrent {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currDateString = [dateformatter stringFromDate:currentDate];
    
    return currDateString;
}

@end
