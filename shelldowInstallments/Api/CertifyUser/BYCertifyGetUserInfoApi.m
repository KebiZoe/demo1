//
//  BYCertifyGetUserInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/18.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYCertifyGetUserInfoApi.h"

@implementation BYCertifyGetUserInfoApi
- (NSString *)requestUrl {
    return @"/certifyUser/getuserInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
