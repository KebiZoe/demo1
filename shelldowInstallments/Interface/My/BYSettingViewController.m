//
//  BYSettingViewController.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYSettingViewController.h"
#import "BYLoginoutApi.h"
#import "BYSecurityManager.h"
@interface BYSettingViewController ()

@end

@implementation BYSettingViewController
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"设置";
}
- (void)initSubviews {
    [super initSubviews];
    [self setUpGroup1];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    UIButton *loginOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOut setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    [loginOut setBackgroundImage:[UIImage imageWithColor:UIColorWhite] forState:UIControlStateNormal];
    loginOut.frame = CGRectMake(0, 61, SCREEN_WIDTH, 44);
    loginOut.titleLabel.font = FONT(14);
    [footView addSubview:loginOut];
    [loginOut addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footView;
}
- (void)loginOutAction{
    
}
- (void)setUpGroup1{
    @WeakObj(self);
    ZXXArrowItem *modifyPassword = [ZXXArrowItem itemWithImage:UIImageMake(@"icon_set_password") title:@"修改登录密码" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXArrowItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    ZXXArrowItem *aboutUs = [ZXXArrowItem itemWithImage:UIImageMake(@"icon_set_us") title:@"关于我们" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXArrowItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[modifyPassword,aboutUs];
    [self.groups addObject:group];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = YES;
#pragma clang diagnostic pop
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
