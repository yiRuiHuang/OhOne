//
//  ArticleViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ArticleViewController.h"
#import "ShareView.h"
#import "UIViewExt.h"
#import "ArticleModel.h"
#import "ArticleView.h"
#import "iCarousel.h"
#import "HTTPTool.h"
#import "BaseFunction.h"
#import "UMSocial.h"

@interface ArticleViewController () <iCarouselDataSource,iCarouselDelegate>
{
    BOOL flag;     // 导航栏按钮点击
    
    iCarousel *_carousel;
    
    // 当前一共有多少篇文章，默认为3篇
    //    NSInteger numberOfItems;
    
    // 保存当前查看过的数据
    NSMutableDictionary *readItems;
    
    // 最后展示的 item 的下标
    NSInteger lastConfigureViewForItemIndex;
    // 当前是否正在右拉刷新标记
    BOOL isRefreshing;
    
    
    NSString *lastUpdateDate;
}

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    readItems = [[NSMutableDictionary alloc] init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    lastUpdateDate = [BaseFunction stringDateBeforeTodaySeveralDays:0];
    
    [self _createCarousel];
    
    [self requestReadingContentAtIndex:0];
    
    
    //    分享界面
    [self _creatShareView];


    // Do any additional setup after loading the view.
  
}



- (void)_createCarousel {
    
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_carousel];
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.pagingEnabled = YES;

}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
//        return numberOfItems;
    return readItems.allKeys.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    ArticleView *articleView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight-49-64)];
        articleView = [[ArticleView alloc] initWithFrame:view.bounds];
        [view addSubview:articleView];
    } else {
        articleView = (ArticleView *)view.subviews[0];
    }
    articleView.model = readItems[[@(index) stringValue]];
    
    
    return view;
    
    
}



- (void)insertItems
{
    //    NSInteger index = MAX(0, self.carousel.currentItemIndex);
#warning change 加在后面
    NSInteger index = MAX(0, _carousel.currentItemIndex)+1 ;

    
    [self requestReadingContentAtIndex:index];

    
    [_carousel insertItemAtIndex:index animated:YES];
    
}

#pragma mark -
- (void)carouselDidScroll:(iCarousel *)carousel {
    
//    NSLog(@"%f",carousel.scrollOffset);
    if (carousel.scrollOffset >= 0.35) {
        
        
        [self insertItems];
        
    }
    //    NSLog(@"count:%ld",readItems.allKeys.count);
    
}


#pragma mark - Network Requests
//- (void)refreshing {
//    if (readItems.allKeys.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
//        //        [self showHUDWithText:@""];
//        isRefreshing = YES;
//        [self requestReadingContentAtIndex:0];
//    }
//}

- (void)requestReadingContentAtIndex:(NSInteger)index {

    NSString *date = [BaseFunction stringDateBeforeTodaySeveralDays:index];
    
    [HTTPTool requestReadingContentByDate:date lastUpdateDate:lastUpdateDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *entTg = responseObject[@"contentEntity"];
        
        ArticleModel *model = [[ArticleModel alloc] init];
        
        [model setValuesForKeysWithDictionary:entTg];
        
//        NSLog(@"%@",model);
        [readItems setObject:model forKey:[@(index) stringValue]];
        
        //        [_carousel reloadItemAtIndex:index animated:YES];
        [_carousel reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
        
 
}






#pragma mark - shareView
- (void)_creatShareView {
    //    self.shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, kShareHeight) Type:0];
    //    [self.view addSubview:self.shareView];
    //
    [self.rightButton addTarget:self  action:@selector(showSahreView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showSahreView {
    NSLog(@"%ld",(long)_carousel.currentItemIndex);
    NSInteger index = _carousel.currentItemIndex;
    NSString *indexStr = [NSString stringWithFormat:@"%li",index];
    ArticleModel *model = readItems[indexStr];
    
    NSString *shareText = [NSString stringWithFormat:@"One 文章分享：%@ 作者/%@。%@",model.strContTitle,model.strContAuthor,[NSString stringWithFormat:@"%@%@",@"http://m.wufazhuce.com/article/",model.strContMarketTime]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:nil];
    
}
//- (void)_creatShareView {
//    self.shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, kShareHeight) Type:1];
//    [self.view addSubview:self.shareView];
//    
//    [self.rightButton addTarget:self  action:@selector(showSahreView) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)showSahreView {
//    if (!flag){
//        [UIView animateWithDuration:0.5 animations:^{
//            self.shareView.top = kHeight-kShareHeight;
//            self.coverView.hidden = NO;
//#warning change hyr
//            [self.view bringSubviewToFront:self.coverView];
//            [self.view insertSubview:self.shareView aboveSubview:self.coverView];
//            
//        }];
//        flag = YES;
//    } else {
//        [self coverTapAction:self.coverView];
//        flag = NO;
//    }
//}





// 页面消失时关闭分享状态
- (void)viewWillDisappear:(BOOL)animated {
    if (flag == YES) {
        [self coverTapAction:self.coverView];
        flag = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
