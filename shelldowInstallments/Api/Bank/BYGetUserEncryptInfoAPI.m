//
//  BYGetUserEncryptInfoAPI.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetUserEncryptInfoAPI.h"

@implementation BYGetUserEncryptInfoAPI
- (NSString *)requestUrl {
    return @"/query/getUserEncryptInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
