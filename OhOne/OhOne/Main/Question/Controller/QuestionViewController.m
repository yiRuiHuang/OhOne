//
//  QuestionViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "QuestionViewController.h"
#import "UIViewExt.h"
#import "iCarousel.h"
#import "HTTPTool.h"
#import "QuestionView.h"
#import "QuestionModel.h"
#import "BaseFunction.h"
#import "UMSocial.h"

@interface QuestionViewController ()
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
    
    NSString *lastUpdateDate;
    
    QuestionView *questionView;

    
}
@end

@implementation QuestionViewController

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
    lastUpdateDate = [BaseFunction stringDateBeforeTodaySeveralDays:0];

    
    [self _createCarousel];
    
    [self requestHomeContentAtIndex:0];
    
    
    //    分享界面
    [self _creatShareView];
}


- (void)_createCarousel {
    
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_carousel];
    _carousel.pagingEnabled = YES;
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    //    return numberOfItems;
    return readItems.allKeys.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    questionView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight-49-64)];
        questionView = [[QuestionView alloc] initWithFrame:view.bounds];
        [view addSubview:questionView];
    } else {
        questionView = (QuestionView *)view.subviews[0];
    }
    

    questionView.model = readItems[[@(index) stringValue]];
    
    
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
//- (void)refreshing {
//    if (readItems.allKeys.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
//        //        [self showHUDWithText:@""];
//        isRefreshing = YES;
//        [self requestHomeContentAtIndex:0];
//    }
//}

- (void)requestHomeContentAtIndex:(NSInteger)index {
    NSString *date = [BaseFunction stringDateBeforeTodaySeveralDays:index];

    [HTTPTool requestQuestionContentByDate:date lastUpdateDate:lastUpdateDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *entTg = responseObject[@"questionAdEntity"];
        
        QuestionModel *model = [[QuestionModel alloc] init];
        
        [model setValuesForKeysWithDictionary:entTg];
        
//        NSLog(@"%@",model);
        [readItems setObject:model forKey:[@(index) stringValue]];
        
        //        [_carousel reloadItemAtIndex:index animated:YES];
        [_carousel reloadData];

    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
    

    
    
}




//#pragma mark - shareView
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
    QuestionModel *model = readItems[indexStr];

    
    NSString *shareText = [NSString stringWithFormat:@"%@ %@",model.strQuestionTitle,[NSString stringWithFormat:@"%@%@",@"http://m.wufazhuce.com/question/",model.strQuestionMarketTime]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"huwenjie.jpg"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:nil];

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
