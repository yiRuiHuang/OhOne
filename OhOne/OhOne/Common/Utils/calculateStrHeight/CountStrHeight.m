//
//  CountStrHeight.m
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "CountStrHeight.h"

@implementation CountStrHeight

+ (CGFloat)countHeightForStr:(NSString *)str FontType:(UIFont *)fontType RowWidth:(CGFloat)rowWidth
{
    if (str == nil) {
        return 0;
    }
    CGSize maxSize = CGSizeMake(rowWidth, 999999);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:fontType forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height+20;
}

@end
