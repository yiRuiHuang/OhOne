//
//  HttpDataService.m
//  HWMovie
//
//  Created by hyrMac on 15/8/15.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "HttpDataService.h"
#import "AFNetworking.h"
#import "common.h"

@implementation HttpDataService


+ (void)requestAFUrl:(NSString *)urlString
          httpMethod:(NSString *)methodString
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
               block:(BlockType)block{
    
    NSString *fullUrlString = [BaseUrl stringByAppendingString:urlString];
    NSLog(@"%@",fullUrlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    if ([methodString isEqualToString:@"GET"]) {
        
        [manager GET:fullUrlString parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
            
//            NSLog(@"%@",responseObject);
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            
            NSLog(@"error:%@",error);
        }];
    }
    
#warning  post方法未修改，当前不可用，只用get方法
    if ([methodString isEqualToString:@"POST"]) {
        if (datas != nil) {
            
            AFHTTPRequestOperation *operation = [manager POST:fullUrlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *name in datas) {
                    NSData *data = [datas objectForKey:name];
                    [formData appendPartWithFileData:data name:name fileName:@"11.png" mimeType:@"image/jpeg"];
                }
                
                [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                    NSLog(@"上传zhong..");
                }];
                
                
            } success:^(AFHTTPRequestOperation * operation, id responseObject) {
                NSLog(@"上传成功");
            } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
                NSLog(@"上传失败%@",error);
            }];
        } else {
            
            AFHTTPRequestOperation *operation = [manager POST:fullUrlString parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
                NSLog(@"成功");
                
                
            } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
                
            }];
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                NSLog(@"上传zhong..");
            }];
            
        }
        
    }
    
    
}


@end
