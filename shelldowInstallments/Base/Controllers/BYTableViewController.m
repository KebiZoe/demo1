//
//  BYTableViewController.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/12.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYTableViewController.h"
#import "NSObject+logVarMethod.h"
@interface BYTableViewController ()

@end

@implementation BYTableViewController
- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
}
- (UIImage *)navigationBarShadowImage{
    return [UIImage qmui_imageWithColor:COLOR_LINE size:CGSizeMake(SCREEN_WIDTH, 1) cornerRadius:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
    [self setHandle_UIEvent];
}
- (void)setHandle_UIEvent{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟页面分析
    //    [UMAnalytics beginLogViewController:NSStringFromClass(self.class)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟页面分析
    //    [UMAnalytics endLogViewController:NSStringFromClass(self.class)];
}
#pragma mark —— push下一个页面
/*不传数据，直接push到下一个界面*/
-(void)push:(NSString*)controllerName{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

/*传数据到下一个界面*/
-(void)push:(NSString*)controllerName Data:(id)data{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    ((BYTableViewController*)controller).receivedData=data;
    [self.navigationController pushViewController:controller animated:true];
}
- (BOOL)shouldCustomNavigationBarTransitionWhenPushAppearing{
    return YES;
}
- (BOOL)shouldCustomNavigationBarTransitionWhenPopAppearing{
    return YES;
}
- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing{
    return YES;
}
- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing{
    return YES;
}
#pragma mark —— 返回事件
/*关闭界面，返回上一级*/
-(void)pop{
    if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*返回到固定界面*/
-(void)popToController:(NSString*)controllerName{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[controller class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
}

/*返回到主界面*/
-(void)popToRoot{
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ZXXNavigationProtocol
- (void)pushViewControllerString:(NSString *)controllerString Data:(id)data{
    if (data==nil) {
        [self push:controllerString];
    }else{
        [self push:controllerString Data:data];
    }
}
- (void)popToControllerString:(NSString *)controllerString{
    if (controllerString==nil) {
        [self pop];
    }else{
        [self popToController:controllerString];
    }
}
- (void)popToRootController{
    [self popToRoot];
}
//- (void)transNavigationBar:(BOOL)isTrue{
//    if (isTrue) {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        UIImageView *lineView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//        lineView.hidden = true;
//    } else {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//        UIImageView *lineView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//        lineView.hidden = false;
//    }
//}

@end
