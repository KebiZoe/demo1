//
//  BYMyViewController.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/13.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYMyViewController.h"
#import "BYCertifyGetUserInfoApi.h"
#import "BYGetBlackCheckUrlApi.h"
@interface BYMyViewController ()
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UILabel *telLbl;
@property(nonatomic, strong) UILabel *maxLoan;
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, assign) BOOL blackStatus;
@property(nonatomic, copy) NSString *blackUrl;
@end

@implementation BYMyViewController
- (void)didInitialize {
    [super didInitialize];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_set_mine") target:self action:@selector(handleSettingAction)];
}
- (void)handleSettingAction{
    [self push:@"BYSettingViewController"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[BYSecurityManager sharedInstance] objectForKey:blackConfig]) {
        self.blackStatus = [[[BYSecurityManager sharedInstance] objectForKey:blackConfig] boolValue];
    }
    if ([[BYSecurityManager sharedInstance] objectForKey:userName]) {
        self.telLbl.text = [[BYSecurityManager sharedInstance] objectForKey:userName];
    }
    if ([[BYSecurityManager sharedInstance] objectForKey:productMaxAmt]) {
        self.maxLoan.text = [NSString stringWithFormat:@"最大借款额度:%@",[[BYSecurityManager sharedInstance] objectForKey:productMaxAmt]];
    }
    self.groups = nil;
    [self setUpGroup0];
    [self setUpGroup1];
    [self.tableView reloadData];
}

- (void)startHandleBlackCheckAction{
    BYGetBlackCheckUrlApi *getBlackCheckUrlApi = [[BYGetBlackCheckUrlApi alloc] init];
    getBlackCheckUrlApi.phone = [[BYSecurityManager sharedInstance] objectForKey:mobile];
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] && [[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES) {
        getBlackCheckUrlApi.environment =  @"test";
    }else{
        getBlackCheckUrlApi.environment =  @"prod";
    }
    @WeakObj(self);
    [getBlackCheckUrlApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @StrongObj(self);
        if ([request.responseObject[@"code"] isEqualToString:@"000000"]) {
            self.blackUrl = request.responseObject[@"data"];
            [self push:@"WebViewController" Data:@{
                                                   @"isCareweeLink":@(NO),
                                                   @"url":self.blackUrl
                                                   }];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (UIImage *)navigationBarBackgroundImage{
    return [UIImage imageWithColor:UIColorClear];
}
- (UIImage *)navigationBarShadowImage{
    return [UIImage imageWithColor:UIColorClear];
}
- (UIColor *)navigationBarTintColor{
    return UIColorWhite;
}
- (void)setUpGroup0{
    @WeakObj(self);
    ZXXArrowItem *recorder = [ZXXArrowItem itemWithImage:UIImageMake(@"icon_repay_record") subtitle:@"子标题" title:@"借款记录" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXArrowItem * _Nullable item) {
        @StrongObj(self);
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    

    ZXXLabelItem *bankCard = [ZXXLabelItem itemWithImage:UIImageMake(@"icon_card_mine") subtitle:@"子标题" title:@"银行卡" rightTitle:@"卡号" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
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
    
    ZXXSwitchItem *blackcheck = [ZXXSwitchItem itemWithImage:UIImageMake(@"icon_black_check") subtitle:@"子标题" title:@"黑名单检测" on:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXSwitchItem * _Nullable item) {
        @StrongObj(self);
        [QMUITips showInfo:[NSString stringWithFormat:@"勾选%d",item.on]];
    }];
    ZXXLabelArrowItem *certifyCenter = [ZXXLabelArrowItem itemWithImage:UIImageMake(@"icon_attestation_mine") subtitle:@"子标题" title:@"认证中心" rightTitle:@"未认证" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXLabelArrowItem * _Nullable item) {
        @StrongObj(self)
        
        [self push:@"BYJumpViewController" Data:item.title];
    }];
    
    ZXXCheakItem *service = [ZXXCheakItem itemWithImage:UIImageMake(@"icon_massage_mine") subtitle:@"子标题" title:@"在线客服" cheak:YES WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
        attribute.imageEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        attribute.titleFont = FONT(14);
        attribute.textLabelEdgeInsets = UIEdgeInsetsMake(1, 0, -1, 0);
    } cellHeight:autoScaleW(60) WithOption:^(ZXXCheakItem * _Nullable item) {
        @StrongObj(self)
        item.cheak = !item.cheak;
        [self.tableView reloadData];
    }];
    
    ZXXTextFieldItem *message = [ZXXTextFieldItem itemWithImage:UIImageMake(@"icon_service_mine") subtitle:@"子标题" title:@"消息中心" rightTitle:@"" WithAttribute:^(ZXXAttributeItem * _Nullable attribute) {
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, -scrollView.contentOffset.y);
    }else{
        self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    }
}
- (void)initSubviews {
    [super initSubviews];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
    self.topView.backgroundColor = COLOR_MAIN;
    [self.view addSubview:self.topView];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, autoScaleW(178-64)+(SCREEN_HEIGHT>736?88:64))];
    self.headView.backgroundColor = COLOR_MAIN;
    
    UIImageView *topIcon = [[UIImageView alloc] init];
    topIcon.image = UIImageMake(@"img_decorate_mine");
    [self.topView addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(autoScaleW(0));
        make.size.sizeOffset(CGSizeMake(autoScaleW(313), autoScaleW(104)));
    }];
    
    UIImageView *headIcon = [[UIImageView alloc] init];
    headIcon.image = UIImageMake(@"img_head_mine");
    [self.headView addSubview:headIcon];
    [headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(autoScaleW(6)+(SCREEN_HEIGHT>736?88:64));
        make.left.offset(autoScaleW(27));
        make.size.sizeOffset(CGSizeMake(autoScaleW(98), autoScaleW(98)));
    }];
    
    NSMutableString *phone = ((NSString *)[[BYSecurityManager sharedInstance] objectForKey:mobile]).mutableCopy;
    [phone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"*****"];
    self.telLbl = [UILabel labelWithTitle:phone color:UIColorWhite font:FONT(17)];
    self.maxLoan = [UILabel labelWithTitle:@"10000" color:UIColorWhite font:FONT(14)];
    [self.headView addSubview:self.telLbl];
    [self.headView addSubview:self.maxLoan];
    [self.telLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headIcon.mas_right).offset(15);
        make.centerY.equalTo(headIcon).offset(-autoScaleW(15));
    }];
    [self.maxLoan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headIcon.mas_right).offset(15);
        make.centerY.equalTo(headIcon).offset(autoScaleW(15));
    }];
    
    self.tableView.tableHeaderView = self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 10;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)setButtonIconTopWordsBottom:(UIButton *)btn{
    float  spacing = 10;//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

@end
