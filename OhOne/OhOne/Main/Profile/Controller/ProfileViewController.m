//
//  ProfileViewController.m
//  OhOne
//
//  Created by hyrMac on 15/8/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ProfileViewController.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"

@interface ProfileViewController ()
{
    UITableView *_tableView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createTableView];
    [self _setNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_setNavBar {
    UIImage *image = [UIImage imageNamed:@"navLogo"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-185)/2.0, 12, 185, 20)];
    imgView.contentMode= UIViewContentModeScaleAspectFit;
    imgView.image = image;
    self.navigationItem.titleView = imgView;
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)
                                              style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))]; //单元格的下划线占满屏幕的宽度
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"profileCell"];
    
}

#pragma  - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    if (indexPath.row == 0) {
//        cell.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        cell.imageView.image = [UIImage imageNamed:@"p_notLogin.png"];
        cell.textLabel.text = @"立即登录";
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"setting.png"];
        cell.textLabel.text = @"设置";
    } else {
        cell.imageView.image = [UIImage imageNamed:@"copyright.png"];
        cell.textLabel.text = @"关于";
    }
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


#pragma  mark  - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {// 点击进入个人中心
        
    } else if (indexPath.row == 1) {// 点击进入设置
        SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController:settingsViewController animated:YES];
    } else if (indexPath.row == 2) {// 点击进入关于界面
        AboutViewController *aboutViewController = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}






@end
