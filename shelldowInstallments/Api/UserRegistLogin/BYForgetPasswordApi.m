//
//  BYForgetPasswordApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYForgetPasswordApi.h"

@implementation BYForgetPasswordApi
- (NSString *)requestUrl {
    return @"/User/forgetPassword";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"password":_password,
             @"code":_code,
             @"phone":_phone
             };
}
@end
