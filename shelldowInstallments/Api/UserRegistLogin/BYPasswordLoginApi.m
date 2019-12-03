//
//  BYPasswordLoginApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYPasswordLoginApi.h"

@implementation BYPasswordLoginApi
- (NSString *)requestUrl {
    return @"/User/passwordLogin";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"phone":_phone,
             @"password":_password,
             @"client":@"ios",
             };
}
@end
