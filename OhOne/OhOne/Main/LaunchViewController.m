//
//  LaunchViewController.m
//  OhOne
//
//  Created by 弄潮者 on 15/9/11.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "LaunchViewController.h"
#import "MainTabBarController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGround.image = [UIImage imageNamed:@"launch_image640x960.png"];
    [self.view addSubview:backGround];
    
    [self performSelector:@selector(launchMain) withObject:self afterDelay:3];
    
    // Do any additional setup after loading the view.
}

- (void)launchMain {
    UIWindow *window = self.view.window;
    MainTabBarController *main = [[MainTabBarController alloc] init];
    main.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.3 animations:^{
        main.view.transform = CGAffineTransformIdentity;
    }];
    window.rootViewController = main;
    return;
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
