//
//  ZoomImageView.m
//  HWWeibo
//
//  Created by hyrMac on 15/8/29.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ZoomImageView.h"
//#import "UIImageView+WebCache.h"
#import "DDProgressView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "UIViewExt.h"

@implementation ZoomImageView {
    
    NSMutableData *_fullImgData;
    
    double _totalLength;
    NSURLConnection *_connection;
    
    // 大图下载进度条
    DDProgressView *_progressView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initTap];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initTap];
    }
    return self;
}


- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self initTap];
    }

    return self;
}


- (void)initTap {
    // 打开交互
    self.userInteractionEnabled = YES;
    
//    添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(zoomIn)];
    
    [self addGestureRecognizer:singleTap];
    
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    
}

//放大图片
- (void)zoomIn {
    
    if ([self.delegate respondsToSelector:@selector(imageViewWillZoomIn:)]) {
        [self.delegate imageViewWillZoomIn:self];
    }
    
    
    //  隐藏小图片
    self.hidden = YES;
    
    // 创建大图视图
    [self _createViews];
    
//    计算fullImageView大小
    
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _scrollView.backgroundColor = [UIColor grayColor];
        _fullImageView.frame = _scrollView.bounds;
        
    } completion:^(BOOL finished) {
        
    }];
    
//    下载大图
//    [_fullImageView sd_setImageWithURL:[NSURL URLWithString:_fullImgUrlStr]];
    // 请求网络 下载大图
    if (_fullImgUrlStr.length > 0) {
        
        NSURL *fullImgUrl = [NSURL URLWithString:_fullImgUrlStr];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fullImgUrl cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        
        
        _connection =  [NSURLConnection connectionWithRequest:request delegate:self];
        
    }
    
}


- (void)zoomOut {
    
    if ([self.delegate respondsToSelector:@selector(imageViewWillZoomOut:)]) {
        [self.delegate imageViewWillZoomOut:self];
    }
    
    
    // 跳出时，取消网络下载
    [_connection cancel];
    
    self.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _scrollView.backgroundColor = [UIColor clearColor];
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        _progressView = nil;
        
    }];
    
}

- (void)_createViews {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        
        
        
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.image = self.image;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_scrollView addSubview:_fullImageView];
        
        
        
        
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(zoomOut)];
        
        [_scrollView addGestureRecognizer:singleTap];
        
        
        
        
//        保存大图，添加手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        
        [_scrollView addGestureRecognizer:longPressGesture];
        
        
        
//        进度条
        _progressView = [[DDProgressView alloc] init];
        _progressView.frame = CGRectMake(10, kHeight/2, kWidth-20, 40);
        _progressView.outerColor = [UIColor yellowColor];
        _progressView.innerColor = [UIColor lightGrayColor];
        _progressView.emptyColor = [UIColor darkGrayColor];
        _progressView.hidden = YES;
        
        [_scrollView addSubview:_progressView];
    }
    
    
}

#pragma mark - 网络代理
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *responser = (NSHTTPURLResponse *)response;
    
    NSDictionary *fullHeaderFields = responser.allHeaderFields;
//    NSLog(@"%@",fullHeaderFields);
    _totalLength = [[fullHeaderFields objectForKey:@"Content-Length"] doubleValue];
    
    
    _fullImgData = [[NSMutableData alloc] init];
    
//开始下载的时候不隐藏
    _progressView.hidden = NO;
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    
    
    
    [_fullImgData appendData:data];
    
    _progressView.progress = (double)_fullImgData.length/_totalLength;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    UIImage *image = [UIImage imageWithData:_fullImgData];
    _fullImageView.image = image;
    
//    下载完毕后隐藏
    _progressView.hidden = YES;
    
    
    //处理imageView尺寸
    // 图片的长/图片的宽 ==  ImageView.长（？）/屏幕宽
    [UIView animateWithDuration:0.5 animations:^{
        
        CGFloat length = image.size.height/image.size.width * kWidth;
        if (length < kHeight) {
            _fullImageView.top = (kHeight-length)/2;
        }
        _fullImageView.height = length;
        _scrollView.contentSize = CGSizeMake(kWidth, length);
        
        
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor grayColor];
        
    }];
    
    
    if (self.isGif == YES) {
        [self gifImageShow];
    }
    

    
}

#pragma  mark  - 长按保存图片方法

- (void)savePhoto:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        // 弹出提示框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        UIImage *img = [UIImage imageWithData:_fullImgData];
        
//        保存提示
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        
//        将大图保存到相册
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)hud);
        
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    //提示保存成功
    MBProgressHUD *hud = (__bridge MBProgressHUD *)(contextInfo);
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
}

#pragma mark - gif播放
- (void)gifImageShow {
    
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_fullImgData];
}

@end








