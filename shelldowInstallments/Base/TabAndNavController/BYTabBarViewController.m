//
//  BYTabBarViewController.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/12.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYTabBarViewController.h"
#import "BYNavigationController.h"
#import "BYMyViewController.h"
#import "BYMyViewController1.h"
#import "BYMyViewController2.h"
#import "BYBaseViewController.h"
@interface BYTabBarViewController ()
@property(nonatomic, strong) BYMyViewController1 *firstTabViewController;
@property (nonatomic, strong) BYMyViewController2 *secondTabViewController;
@property(nonatomic, strong) BYMyViewController *thirdTabViewController;
@property(nonatomic, assign) NSInteger indexFlag;
@end

@implementation BYTabBarViewController
- (void)didInitialize {
    [super didInitialize];
    _firstTabViewController=[[BYMyViewController1 alloc] init];
    BYNavigationController *rootNavi1 =[[BYNavigationController alloc] initWithRootViewController:_firstTabViewController];
    rootNavi1.tabBarItem.title=FIRSTTAB_TITLE;
    rootNavi1.tabBarItem.image=FIRSTTAB_ICON;
    rootNavi1.tabBarItem.selectedImage = FIRSTTAB_SELECTED_ICON;
    
    _secondTabViewController=[[BYMyViewController2 alloc] init];
    BYNavigationController *rootNavi2 =[[BYNavigationController alloc] initWithRootViewController:_secondTabViewController];
    rootNavi2.tabBarItem.title=SECONDTAB_TITLE;
    rootNavi2.tabBarItem.image=SECONDTAB_ICON;
    rootNavi2.tabBarItem.selectedImage = SECONDTAB_SELECTED_ICON;
    
    _thirdTabViewController=[[BYMyViewController alloc] init];
    BYNavigationController *rootNavi3 =[[BYNavigationController alloc] initWithRootViewController:_thirdTabViewController];
    rootNavi3.tabBarItem.title=THIRDTAB_TITLE;
    rootNavi3.tabBarItem.image=THIRDTAB_ICON;
    rootNavi3.tabBarItem.selectedImage = THIRDTAB_SELECTED_ICON;
    self.viewControllers=@[rootNavi1,rootNavi2,rootNavi3];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            [btn.layer removeAllAnimations];
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        UIView *view = arry[index];
        // 位置移动
        CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        // 阻尼系数（此值越大弹框效果越不明显）
        animation.damping = 8;
        // 刚度系数（此值越大弹框效果越明显）
        animation.stiffness = 100;
        // 质量大小（越大惯性越大）
        animation.mass = 1;
        animation.initialVelocity = 1;
        animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.0];
        animation.removedOnCompletion = YES;
        // 持续时间
        animation.duration = animation.settlingDuration;
        [[view layer] addAnimation:animation forKey:nil];
        self.indexFlag = index;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedItemWithUserInfo:) name:TabBarViewControllerNotification object:nil];
    // Do any additional setup after loading the view.
}

/**
 @{
 @"index":
 @"ViewControllerName":
 }
 */
- (void)changeSelectedItemWithUserInfo:(NSNotification *)notify{
    NSInteger idx = [notify.userInfo[@"index"] integerValue];
    NSString *vcName = notify.userInfo[@"ViewControllerName"];
    self.selectedIndex = idx;
    id data;
    if ([notify.userInfo containsObjectForKey:@"data"]) {
        data = notify.userInfo[@"data"];
        if (vcName.length>0) {
            Class class=NSClassFromString(vcName);
            id controller=[[class alloc] init];
            if ([controller isKindOfClass:BYBaseViewController.class]) {
                ((BYBaseViewController*)controller).receivedData=data;
            }else if ([controller isKindOfClass:BYTableViewController.class]){
                ((BYTableViewController*)controller).receivedData=data;
            }
            switch (idx) {
                case 0:
                    [self.firstTabViewController push:vcName Data:data];
                    break;
                case 1:
                    [self.secondTabViewController.navigationController pushViewController:controller animated:NO];
                    break;
                case 2:
                    [self.thirdTabViewController.navigationController pushViewController:controller animated:NO];
                    break;
                default:
                    break;
            }
        }
    }else{
        if (vcName.length>0) {
            Class class=NSClassFromString(vcName);
            id controller=[[class alloc] init];
            switch (idx) {
                case 0:
                    [self.firstTabViewController.navigationController pushViewController:controller animated:NO];
                    break;
                case 1:
                    [self.secondTabViewController.navigationController pushViewController:controller animated:NO];
                    break;
                case 2:
                    [self.thirdTabViewController.navigationController pushViewController:controller animated:NO];
                    break;
                default:
                    break;
            }
        }
    }
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
