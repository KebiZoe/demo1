//
//  AppDelegate.m
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/5/13.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "AppDelegate.h"
#import "BYNavigationController.h"
#import "BYTabBarViewController.h"
#import <YTKNetwork/YTKNetwork.h>
#import <Bugly/Bugly.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadWindows];
    [self initYTKNetWork];
    [self initTalkingData];
    
    [self chooseRootViewController:@"BYTabBarViewController"];
    
    [self setShortCutItemsWithApplication:application];
    return YES;
}

- (void)setShortCutItemsWithApplication:(UIApplication *)application{
    UIApplicationShortcutIcon *iconShare = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];        //菜单文字
    UIMutableApplicationShortcutItem *itemShare = [[UIMutableApplicationShortcutItem alloc] initWithType:@"ShortCutShare" localizedTitle:@"分享"];        //绑定信息到指定菜单
    itemShare.icon = iconShare;        //绑定到App icon
    application.shortcutItems = @[itemShare];
}
- (void)initTalkingData{
    [Bugly startWithAppId:Bugly_ID];
}
- (void)openBugoutShakeFeedBack:(BOOL)enabledShakeFeedback{
    YTKNetworkConfig *netConfig = [YTKNetworkConfig sharedConfig];
    netConfig.baseUrl = enabledShakeFeedback==YES?BASE_URL_TEST:BASE_URL;
}
-(void)chooseRootViewController:(NSString *)nameOfVc{
    if([nameOfVc isEqualToString:@"WelComeViewController"]){
        
    }else if([nameOfVc isEqualToString:@"BYLoginViewController"]){
//        BYLoginViewController *loginVc = [[BYLoginViewController alloc] init];
//        BYNavigationController *navVc = [[BYNavigationController alloc] initWithRootViewController:loginVc];
//        self.window.rootViewController = navVc;
    }else if([nameOfVc isEqualToString:@"BYTabBarViewController"]){
        BYTabBarViewController *tabVC = [[BYTabBarViewController alloc] init];
        self.window.rootViewController = tabVC;
    }
}
- (void)initYTKNetWork{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP]) {
        if([[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES){
            config.baseUrl = BASE_URL_TEST;
        }else{
            config.baseUrl = BASE_URL;
        }
    }else{
        config.baseUrl = BASE_URL;
    }
    
}
- (void)loadWindows{
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"ShortCutShare"]) {
        [QMUITips showWithText:@"分享功能还未开放"];
    }
}

@end
