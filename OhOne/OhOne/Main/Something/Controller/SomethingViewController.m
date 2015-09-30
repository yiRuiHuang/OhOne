//
//  SomethingViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "SomethingViewController.h"
#import "UIViewExt.h"

#import "HomeViewController.h"
#import "ShareView.h"
#import "UIViewExt.h"
#import "HttpDataService.h"
#import "HomeModel.h"
#import "HomeView.h"

#import "iCarousel.h"
#import "HTTPTool.h"

#import "SomethingModel.h"
#import "SomethingView.h"
#import "UMSocial.h"

@interface SomethingViewController ()
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

@implementation SomethingViewController
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
    
    SomethingView *somethingView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight-49-64)];
        somethingView = [[SomethingView alloc] initWithFrame:view.bounds];
        [view addSubview:somethingView];
    } else {
        somethingView = (SomethingView *)view.subviews[0];
    }
    
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    //    if (index == numberOfItems - 1 || index == readItems.allKeys.count) {// 当前这个 item 是没有展示过的
    ////        [homeView refreshSubviewsForNewItem];
    //    } else {// 当前这个 item 是展示过了但是没有显示过数据的
    //        lastConfigureViewForItemIndex = MAX(index, lastConfigureViewForItemIndex);
    ////        [homeView configureViewWithHomeEntity:readItems[[@(index) stringValue]] animated:YES];
    //        homeView.model = readItems[[@(index) stringValue]];
    //
    //    }
    somethingView.model = readItems[[@(index) stringValue]];
    
    
    return view;
    
    
}



- (void)insertItem
{
    //    NSInteger index = MAX(0, self.carousel.currentItemIndex);
#warning change 加在后面
    NSInteger index = MAX(0, _carousel.currentItemIndex)+1;
    
    [self requestHomeContentAtIndex:index];
    //    [items insertObject:@(_carousel.numberOfItems) atIndex:(NSUInteger)index];
    [_carousel insertItemAtIndex:index animated:YES];
}

#pragma mark -
- (void)carouselDidScroll:(iCarousel *)carousel {
    
//    NSLog(@"%f",carousel.scrollOffset);
    if (carousel.scrollOffset >= 0.35) {
        
        [self insertItem];
        
    }
    
}


#pragma mark - Network Requests

// 右拉刷新
- (void)refreshing {
    if (readItems.allKeys.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
        //        [self showHUDWithText:@""];
        isRefreshing = YES;
        [self requestHomeContentAtIndex:0];
    }
}

- (void)requestHomeContentAtIndex:(NSInteger)index {
    [HTTPTool requestThingContentByIndex:index success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *entTg = responseObject[@"entTg"];
        
        SomethingModel *model = [[SomethingModel alloc] init];
        
        [model setValuesForKeysWithDictionary:entTg];
        
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
//    NSLog(@"%ld",(long)_carousel.currentItemIndex);
    NSInteger index = _carousel.currentItemIndex;
    NSString *indexStr = [NSString stringWithFormat:@"%li",index];
    SomethingModel *model = readItems[indexStr];
    
    
    NSString *shareText = [NSString stringWithFormat:@"%@。%@ %@",model.strTt,model.strTc,model.strWu];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareText
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.strBu]]]
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
