//
//  BYMyViewController2.m
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/12/3.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYMyViewController2.h"

@interface BYMyViewController2 ()

@end

@implementation BYMyViewController2

- (void)didInitialize {
    [super didInitialize];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"分期";
}

- (void)setUpGroup0{
    @WeakObj(self);
    
    ZXXArrowItem *recorder = [ZXXArrowItem itemWithImage:UIImageMake(@"icon_repay_record") title:@"借款记录" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXArrowItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    

    ZXXLabelItem *bankCard = [ZXXLabelItem itemWithImage:UIImageMake(@"icon_card_mine") title:@"银行卡" rightTitle:@"卡号" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
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
    
    ZXXSwitchItem *blackcheck = [ZXXSwitchItem itemWithImage:UIImageMake(@"icon_black_check") title:@"黑名单检测" on:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXSwitchItem * _Nullable item) {
        @StrongObj(self);
        [QMUITips showInfo:[NSString stringWithFormat:@"勾选%d",item.on]];
    }];
    ZXXLabelArrowItem *certifyCenter = [ZXXLabelArrowItem itemWithImage:UIImageMake(@"icon_attestation_mine") title:@"认证中心" rightTitle:@"未认证" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXLabelArrowItem * _Nullable item) {
        @StrongObj(self)
        
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    
    ZXXCheakItem *service = [ZXXCheakItem itemWithImage:UIImageMake(@"icon_massage_mine") title:@"在线客服" cheak:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self)
        item.cheak = !item.cheak;
        [self.tableView reloadData];
    }];
    
    ZXXTextFieldItem *message = [ZXXTextFieldItem itemWithImage:UIImageMake(@"icon_service_mine") title:@"消息中心" rightTitle:@"" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
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

@end
