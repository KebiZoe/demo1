//
//  BYBaseViewController.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/12.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYBaseViewController.h"
#import <objc/message.h>
#import "NSObject+logVarMethod.h"
@interface BYBaseViewController ()

@end

@implementation BYBaseViewController{
    UIView *_baseView;
}

+ (void)load{
    Method a = class_getInstanceMethod(self, @selector(loadView));
    Method b = class_getInstanceMethod(self, @selector(loadCustomView));
    method_exchangeImplementations(a, b);
}
- (void)loadView{
    [super loadView];
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [[UIView alloc] init];
    }
    return _baseView;
}

- (void)didInitialize {
    [super didInitialize];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
}
- (void)loadCustomView{
    self.view = self.baseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHandle_UIEvent];
}

- (void)setHandle_UIEvent{
    
}
- (void)initSubviews {
    [super initSubviews];
    self.view.backgroundColor = COLOR_BACKGROUND;
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
- (UIImage *)navigationBarShadowImage{
    return [UIImage qmui_imageWithColor:COLOR_LINE size:CGSizeMake(SCREEN_WIDTH, 1) cornerRadius:0];
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
    ((BYBaseViewController*)controller).receivedData=data;
    [self.navigationController pushViewController:controller animated:true];
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
#pragma mark - ZXXNavigationProtocol
- (void)vmpushViewControllerString:(NSString *)controllerString Data:(id)data{
    if (data==nil) {
        [self push:controllerString];
    }else{
        [self push:controllerString Data:data];
    }
}
- (void)vmpopToControllerString:(NSString *)controllerString{
    if (controllerString==nil) {
        [self pop];
    }else{
        [self popToController:controllerString];
    }
}
- (void)vmpopToRootController{
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
