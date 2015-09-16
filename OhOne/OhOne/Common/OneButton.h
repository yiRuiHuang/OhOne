//
//  HWButton.h
//  HWMovie
//
//  Created by gj on 15/7/17.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OneButton : UIControl{
    UIImageView  *_imgView;
    UILabel *_lable;
}

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName  withTitle:(NSString *)title;





@end
