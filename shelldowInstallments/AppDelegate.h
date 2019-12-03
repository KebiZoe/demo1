//
//  AppDelegate.h
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/5/13.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)openBugoutShakeFeedBack:(BOOL)enabledShakeFeedback;
-(void)chooseRootViewController:(NSString *)nameOfVc;

@end

