//
//  Const(常量文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Const_______h
#define Const_______h


/**api请求地址*/
static NSString* const BASE_URL_TEST=@"";
static NSString* const BASE_URL = @"";
/** Bugly */
static NSString* const Bugly_ID=@"4ed5f9f640";
/**https://release.rank-tech.com*/
static NSString* const Release_TeamId=@"5bc973a13ecd376b3cd1dadb";
/** 有盾authkey */
static NSString* const UDAUTHKEY = @"";
/**申请界面用户协议*/
static NSString* const APPLYPROTOCOL_URL = @"";

#pragma mark - reuseIdentifier - 重用标识
/**cell重用标识*/
// BaseSetingViewCell
static NSString* const CELLCOMMON = @"CELLCOMMON_IDENTIFIER";
static NSString* const CELLCOMMON_EDIT = @"CELLCOMMON_EDIT_IDENTIFIER";


#pragma mark - User_default Keys
/** 用户信息NSDictionary */
static NSString* const token = @"token";
static NSString* const hasPassword = @"hasPassword";
static NSString* const mobile = @"mobile";
static NSString* const userName = @"userName";
static NSString* const userIDCard = @"userIDCard";

static NSString* const switchBase_URL_IP = @"switchBase_URL_IP";
static NSString* const customerImage = @"customerImage";
static NSString* const merchantConfig = @"merchantConfig";
static NSString* const blackConfig = @"blackConfig";
static NSString* const renewalConfig = @"renewalConfig";
static NSString* const merchantStatus = @"merchantStatus";
static NSString* const paycheckSwitch = @"paycheckSwitch";
static NSString* const productMaxAmt = @"productMaxAmt";
#pragma mark - FONT_name_size
/**COMMON_NAME*/
static NSString* const FONT_NAME = @"PingFangSC-Regular";
static NSString* const FONT_BODY = @"PingFangSC-Semibold";

#endif /* Const_______h */
