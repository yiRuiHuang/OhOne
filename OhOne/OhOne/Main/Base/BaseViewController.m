//
//  BaseViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewExt.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self _setNavBar];
    [self _createCoverView];
    
}

- (void)_setNavBar {
    UIImage *image = [UIImage imageNamed:@"navLogo"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-185)/2.0, 12, 185, 20)];
    imgView.contentMode= UIViewContentModeScaleAspectFit;
    imgView.image = image;
    self.navigationItem.titleView = imgView;
    
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [_rightButton setImage:[UIImage imageNamed:@"shareBtn_iPad@2x.png"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"shareBtn_hl_iPad@2x.png"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    
}


#pragma mark - coverView
- (void)_createCoverView{
    _coverView = [[UIControl alloc]initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    _coverView.hidden = YES;
    
    [_coverView addTarget:self action:@selector(coverTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_coverView];
}

- (void)coverTapAction:(UIControl *)control{
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        _shareView.top = kHeight;
        _coverView.hidden = YES;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 0;
//}
//
//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
