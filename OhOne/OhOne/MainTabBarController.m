//
//  MainTabBarController.m
//  OhOne
//
//  Created by hyrMac on 15/8/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "ArticleViewController.h"
#import "QuestionViewController.h"
#import "SomethingViewController.h"
#import "ProfileViewController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()
{
    UIButton *selButton;
}


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createSubControllers];
//    [self _setTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createSubControllers {
    
    /**
     除了ProfileViewController，其他vc都是继承自BaseViewController
     */
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    QuestionViewController *questionVC = [[QuestionViewController alloc] init];
    SomethingViewController *somethingVC = [[SomethingViewController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    /**
     *VCArray中的4个对象对应的是BaseNavigationController
     */
    NSArray *VCArray = @[homeVC,articleVC,questionVC,somethingVC];
    
    NSMutableArray *navArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < VCArray.count; i++) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:VCArray[i]];
        [navArray addObject:nav];
    }
    
    
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profileVC];
    [navArray addObject:profileNav];
    
    self.viewControllers = navArray;
    
    
    /**
     *  
     设置标签的图案和文字
     */
    NSArray *titles = @[@"首页",@"文章",@"问题",@"东西",@"个人"];
    NSArray *buttonImageNames = @[@"home.png",@"reading.png",@"question.png",@"thing.png",@"person.png"];
//    NSArray *buttonHlImageNames = @[@"homeSelected.png",@"readingSelected.png",@"questionSelected.png",@"thingSelected.png",@"personSelected.png"];
    
    for (NSInteger i = 0; i < 5; i++) {
    
        UITabBarItem *button = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:buttonImageNames[i]] tag:i];
//        button.selectedImage = [UIImage imageNamed:buttonHlImageNames[i]];
        BaseNavigationController *nav = navArray[i];
        nav.tabBarItem = button;

    }
    
    
}




#pragma mark - 标签 弃用

- (void)_setTabBar {
    // 01 tabBar.subviews移除
    Class cls = NSClassFromString(@"UITabBarButton");
    for (UIView *subView in self.tabBar.subviews) {
        //        NSLog(@"%@",[self.tabBar.subviews[0] class]);  //UITabBarButton
        if ([subView isKindOfClass:cls]) {
            
            [subView removeFromSuperview];
        }
    }
    
    // 02 tabBar背景
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    // tabBar透明
    self.tabBar.translucent = YES;
    
    CGFloat tabBarButtonWidth = CGRectGetWidth(self.tabBar.frame)/5;
    CGFloat tabBarButtonHeight = CGRectGetHeight(self.tabBar.frame);
    
    // 03 tabBar.subviews -> 按钮添加
    NSArray *buttonImageNames = @[@"home.png",@"reading.png",@"question.png",@"thing.png",@"person.png"];
//    NSArray *buttonNames = @[@"home_iPad",@"content_iPad",@"question_iPad",@"things_iPad",@"personal_iPad"];
    
    NSArray *buttonHlImageNames = @[@"homeSelected.png",@"readingSelected.png",@"questionSelected.png",@"thingSelected.png",@"personSelected.png"];
//    NSArray *buttonHlNames = @[@"home_hl_iPad",@"content_hl_iPad",@"question_hl_iPad",@"things_hl_iPad",@"person_hl_iPad.png"];
    
//    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
//        
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight)];
//        [button setImage:buttonImageNames[i] forState:UIControlStateNormal];
//        [button setImage:buttonHlImageNames[i] forState:UIControlStateSelected];
//        button.tag = i;
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:button];
//
//    }
//

    for (NSInteger i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight)];
        [button setImage:[UIImage imageNamed:buttonImageNames[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonHlImageNames[i]] forState:UIControlStateSelected];

        
        if (i == 0) {
            button.selected = YES;
            selButton = button;
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }
    
    
}

- (void)buttonAction:(UIButton *)button {
    
    selButton.selected = NO;
    
    self.selectedIndex = button.tag;
    selButton = button;
    
    button.selected = !button.selected;
    
}




@end
