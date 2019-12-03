//
//  Macro(宏文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import "RACEXTScopeZxx.h"
#ifndef Macro______h
#define Macro______h

///*weak和strong*/
//#define WeakObj(o) __weak typeof(o) o##Weak = o;
//#define StrongObj(o) __strong typeof(o) o = o##Weak;

#pragma mark - 高度和宽度
///这个QMUI宏定义已经做好了

#define autoScaleW(width) (SCREEN_WIDTH/375)*width
#define autoScaleH(height) (SCREEN_HEIGHT/667)*height

#pragma mark - tabbar图标和文字
/**tabbar图标和文字*/
#define FIRSTTAB_TITLE @"首页"
#define SECONDTAB_TITLE @"分期"
#define THIRDTAB_TITLE @"我的"

#define FIRSTTAB_ICON [UIImage imageNamed:@"tab_index_normal"]
#define SECONDTAB_ICON [UIImage imageNamed:@"tab_repay_normal"]
#define THIRDTAB_ICON [UIImage imageNamed:@"tab_mine_normal"]

#define FIRSTTAB_SELECTED_ICON [UIImage imageNamed:@"tab_index_current"]
#define SECONDTAB_SELECTED_ICON [UIImage imageNamed:@"tab_repay_current"]
#define THIRDTAB_SELECTED_ICON [UIImage imageNamed:@"tab_mine_current"]

#pragma mark - 颜色
/**16进制颜色转换*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


#define ClearColor [UIColor clearColor]
#define COLOR_MAIN UIColorFromRGB(0x2f5dd2)
#define COLOR_YELLOW UIColorFromRGB(0xFF7E00)
#define COLOR_BACKGROUND UIColorFromRGB(0xF7F7F7)
#define COLOR_TEXT UIColorFromRGB(0x313131)
#define COLOR_BODY_TEXT UIColorFromRGB(0x1A1A1A)
#define COLOR_LINE UIColorFromRGB(0xEDEDEF)
#define COLOR_LIGHT_TEXT UIColorFromRGB(0xB0B2BF)
#define COLOR_DUCK_TEXT UIColorFromRGB(0x666666)
#define COLOR_C0C0C0 UIColorFromRGB(0xC0C0C0)
#define COLOR_CONTACT UIColorFromRGB(0xCD1A1A)

#pragma mark - 带有边框的
/**带有边框的*/
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**FONT*/
#pragma mark - FONT
#define FONT(fontsize) [UIFont fontWithName:FONT_NAME size:(autoScaleW(fontsize))]
#define FONTBODY(fontsize) [UIFont fontWithName:FONT_BODY size:(autoScaleW(fontsize))]

#if TARGET_IPHONE_SIMULATOR//模拟器
#elif TARGET_OS_IPHONE//真机
#endif

#ifdef DEBUG//调试
#define ZXXLog(...) NSLog(__VA_ARGS__)
#else//发布
#define ZXXLog(...)
#endif

#define diagnosticIgnored(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* Macro______h */


#ifndef Notification_________h
#define Notification_________h

#define NOTIFICATION(name,object,userInfo) [NSNotification notificationWithName:name object:object userInfo:userInfo]

static NSString  * const TabBarViewControllerNotification = @"TabBarViewControllerNotification";
static NSString  * const uploadContacts = @"uploadContacts";
#endif /* Notification_________h */
