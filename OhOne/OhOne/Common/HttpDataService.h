//
//  HttpDataService.h
//  HWMovie
//
//  Created by hyrMac on 15/8/15.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockType) (id);
@interface HttpDataService : NSObject

+ (void)requestAFUrl:(NSString *)urlString
          httpMethod:(NSString *)methodString
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
               block:(BlockType)block;
@end
