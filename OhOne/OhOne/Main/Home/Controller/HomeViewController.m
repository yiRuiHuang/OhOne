//
//  HomeViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "HomeViewController.h"
#import "ShareView.h"
#import "UIViewExt.h"
#import "HttpDataService.h"
#import "HomeModel.h"
#import "HomeView.h"
#import "iCarousel.h"
#import "HTTPTool.h"
#import "UMSocial.h"

@interface HomeViewController () <iCarouselDataSource,iCarouselDelegate>
{
    BOOL flag;     // 导航栏按钮点击
    
    iCarousel *_carousel;
    
    // 当前一共有多少篇文章，默认为3篇
    NSInteger numberOfItems;
    
    // 保存当前查看过的数据
    NSMutableDictionary *readItems;
    
    // 最后展示的 item 的下标
    NSInteger lastConfigureViewForItemIndex;
    // 当前是否正在右拉刷新标记
    BOOL isRefreshing;
    
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self _createCollectionView];
//    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-49-64)];
//    [self.view addSubview:_homeView];
    

    numberOfItems = 0;
    readItems = [[NSMutableDictionary alloc] init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    
    [self _createCarousel];

    [self requestHomeContentAtIndex:0];
    
    
//    分享界面
    [self _creatShareView];
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
    
//    return numberOfItems;
    return readItems.allKeys.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    HomeView *homeView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight-49-64)];
        homeView = [[HomeView alloc] initWithFrame:view.bounds];
        [view addSubview:homeView];
    } else {
        homeView = (HomeView *)view.subviews[0];
    }

    homeView.model = readItems[[@(index) stringValue]];
    
    
    return view;

    
}



- (void)insertItem
{
    //    NSInteger index = MAX(0, self.carousel.currentItemIndex);
#warning change 加在后面
    NSInteger index = MAX(0, _carousel.currentItemIndex)+1;
    
    [self requestHomeContentAtIndex:index];
    
    [_carousel insertItemAtIndex:index animated:YES];
}

#pragma mark -
//- (void)carouselDidScroll:(iCarousel *)carousel {
//    
////    NSLog(@"%f",carousel.scrollOffset);
//    
//    
//    
//}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    
    if (carousel.scrollOffset < 0 ) {
        
        
        [self showTextOnly];
        
    }
    
    if (carousel.scrollOffset+1 > readItems.allKeys.count)
        if (carousel.scrollOffset >= (0.35+readItems.allKeys.count-1)) {
            
            [self insertItem];
            
        }
    
}






#pragma mark - Network Requests

- (void)requestHomeContentAtIndex:(NSInteger)index {

    __weak HomeViewController *weakSelf = self;
    [HTTPTool requestHomeContentByIndex:index success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        __strong HomeViewController *strongSelf = weakSelf;
        
//        NSLog(@"%@",responseObject[@"hpEntity"]);
        NSDictionary *hpEntity = responseObject[@"hpEntity"];
        
        HomeModel *model = [[HomeModel alloc] init];
        
        [model setValuesForKeysWithDictionary:hpEntity];
        
        [readItems setObject:model forKey:[@(index) stringValue]];
        
//        [_carousel reloadItemAtIndex:index animated:YES];
        [strongSelf->_carousel reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误：%@",error);
    }];
}



#pragma mark - shareView
- (void)_creatShareView {

    [self.rightButton addTarget:self  action:@selector(showSahreView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showSahreView {
    NSLog(@"%ld",(long)_carousel.currentItemIndex);
    NSInteger index = _carousel.currentItemIndex;
    NSString *indexStr = [NSString stringWithFormat:@"%li",index];
    HomeModel *model = readItems[indexStr];
    
    NSString *shareText = [NSString stringWithFormat:@"%@。%@",model.strContent,[NSString stringWithFormat:@"%@%@",@"http://m.wufazhuce.com/one/",model.strMarketTime]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareText
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.strOriginalImgUrl]]]
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


@end
