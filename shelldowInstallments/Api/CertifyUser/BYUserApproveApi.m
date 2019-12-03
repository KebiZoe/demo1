//
//  BYUserApproveApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/18.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYUserApproveApi.h"

@implementation BYUserApproveApi
- (NSString *)requestUrl {
    return @"/query/userApprove";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
