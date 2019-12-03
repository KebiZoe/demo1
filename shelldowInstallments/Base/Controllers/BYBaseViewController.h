//
//  BYBaseViewController.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/12.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "AppDelegate.h"
#import "BYBaseViewModel.h"
@interface BYBaseViewController : QMUICommonViewController<QMUINavigationTitleViewDelegate,ZXXNavigationProtocol>
///接受上一个界面传过来的数据
@property (strong,nonatomic,nullable) id receivedData;

- (__kindof UIView*_Nonnull)baseView;

/**不传数据，直接push到下一个界面*/
-(void)push:(NSString*_Nonnull)controllerName;

/**传数据到下一个界面*/
-(void)push:(NSString*_Nonnull)controllerName Data:(id _Nonnull)data;

/**关闭界面，返回上一级*/
-(void)pop;

/**返回到固定界面*/
-(void)popToController:(NSString*_Nonnull)controllerName;

/**返回到主界面*/
-(void)popToRoot;
/** 所有的UI事件都放到这里 */
- (void)setHandle_UIEvent;
/** 设置navbar是否透明 */
//- (void)transNavigationBar:(BOOL)isTrue;
@end
