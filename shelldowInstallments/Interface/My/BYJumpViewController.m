//
//  BYJumpViewController.m
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/12/3.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYJumpViewController.h"

@interface BYJumpViewController ()

@end

@implementation BYJumpViewController
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = self.receivedData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lable = [UILabel labelWithTitle:self.receivedData color:UIColorRed font:FONTBODY(30)];
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

@end
