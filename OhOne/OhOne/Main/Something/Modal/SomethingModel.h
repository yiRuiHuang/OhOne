//
//  SomethingModel.h
//  OhOne
//
//  Created by 弄潮者 on 15/9/4.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SomethingModel : NSObject

/**
 strLastUpdateDate "2015-08-13 19:30:16"
 strPn             "0"
 strBu             "http:\/\/pic.yupoo.com\/hanapp\/ESg3Qt2H\/Lsvpw.jpg"
 strTm             "2015-08-14"
 strWu             "https:\/\/item.taobao.com\/item.htm?id=520977866501&from=hanhanbook",
 strId             "587"
 strTt             "All I need is U 在一起 情侣对戒"
 strTc             "金风玉露一相逢，便胜却人间无数。\r\n这个七夕，我想和你【在一起】"
 */


@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *strPn;
@property (nonatomic, copy) NSString *strBu;
@property (nonatomic, copy) NSString *strTm;
@property (nonatomic, copy) NSString *strWu;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTt;
@property (nonatomic, copy) NSString *strTc;


@end
