//
//  BYUserHasPasswordApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYUserHasPasswordApi.h"

@implementation BYUserHasPasswordApi
- (NSString *)requestUrl {
    return @"/query/userHasPassword";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
