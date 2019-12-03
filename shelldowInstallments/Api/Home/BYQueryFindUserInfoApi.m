//
//  BYQueryFindUserInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/10/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYQueryFindUserInfoApi.h"

@implementation BYQueryFindUserInfoApi
- (NSString *)requestUrl {
    return @"/query/findUserInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
