//
//  BYMyViewController1.m
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/12/3.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYMyViewController1.h"

@interface BYMyViewController1 ()

@end

@implementation BYMyViewController1
- (void)didInitialize {
    [super didInitialize];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"首页";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }else{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = YES;
    #pragma clang diagnostic pop
        }
    self.groups = nil;
    [self setUpGroup0];
    [self setUpGroup1];
    [self.tableView reloadData];
}

- (void)setUpGroup0{
    @WeakObj(self);
    
    ZXXArrowItem *recorder = [ZXXArrowItem itemWithTitle:@"借款记录" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXArrowItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    
    ZXXLabelItem *bankCard = [ZXXLabelItem itemWithTitle:@"银行卡" rightTitle:@"卡号" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXLabelItem * _Nullable item) {
        @StrongObj(self);
        
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[recorder,bankCard];
    
    [self.groups addObject:group];
}
- (CellPostNoteType)type{
    return CellPostNoteTypeWithkeyBoardHiden;
}
- (void)setUpGroup1{
    @WeakObj(self);
    
    ZXXSwitchItem *blackcheck = [ZXXSwitchItem itemWithTitle:@"黑名单检测" on:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXSwitchItem * _Nullable item) {
        @StrongObj(self);
        [QMUITips showInfo:[NSString stringWithFormat:@"勾选%d",item.on]];
    }];
    ZXXLabelArrowItem *certifyCenter = [ZXXLabelArrowItem itemWithTitle:@"认证中心" rightTitle:@"未认证" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXLabelArrowItem * _Nullable item) {
        @StrongObj(self)
        
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    
    ZXXCheakItem *service = [ZXXCheakItem itemWithTitle:@"在线客服" cheak:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self)
        item.cheak = !item.cheak;
        [self.tableView reloadData];
    }];
    
    ZXXTextFieldItem *message = [ZXXTextFieldItem itemWithTitle:@"消息中心" rightTitle:@"" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXTextFieldItem * _Nullable item) {
        @StrongObj(self);
        
        
    }];
    
    ZXXGroupItem *group = [[ZXXGroupItem alloc]init];
    group.items = @[blackcheck,certifyCenter,service,message];
    [self.groups addObject:group];
}

@end
