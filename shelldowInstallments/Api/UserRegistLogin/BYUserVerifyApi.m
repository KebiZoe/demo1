//
//  BYUserVerifyApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//  用户输入了验证码进行注册或者登录

#import "BYUserVerifyApi.h"

@implementation BYUserVerifyApi
- (NSString *)requestUrl {
    return @"/User/verify";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    if(_password==nil){
        return @{
                 @"phone":_phone,
                 @"code":_code,
                 @"channelCode":@"IOS",
                 @"client":@"ios",
                 @"owner":@"",
                 };
    }else{
        return @{
                 @"phone":_phone,
                 @"code":_code,
                 @"password":_password,
                 @"channelCode":@"IOS",
                 @"client":@"ios",
                 @"owner":@"",
                 };
    }
    
}
@end
