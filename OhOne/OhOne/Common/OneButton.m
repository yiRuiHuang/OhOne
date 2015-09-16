//
//  HWButton.m
//  HWMovie
//
//  Created by gj on 15/7/17.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "OneButton.h"

@implementation OneButton

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName  withTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        //01 创建imgView
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        // 内容显示模式  等比例
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        //
        _imgView.image = [UIImage imageNamed:imageName];
        [self addSubview:_imgView];
        
        
        
        //02 创建Lable
        _lable = [[UILabel alloc] initWithFrame:CGRectZero];
        _lable.text = title;
        _lable.font = [UIFont systemFontOfSize:14];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.textColor = [UIColor blackColor];
        _lable.backgroundColor = [UIColor redColor];
        [self addSubview:_lable];
    
    }
    return  self;
    
    
}

//在 layoutSubviews 布局子视图
- (void)layoutSubviews{
    
    [super layoutSubviews];
    _imgView.frame = CGRectMake((self.frame.size.width-50)/2, 5, 50 ,50);
    _lable.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame), CGRectGetWidth(self.frame), 20);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
