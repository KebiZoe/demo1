//
//  BYGetCustomerInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/28.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetCustomerInfoApi.h"

@implementation BYGetCustomerInfoApi
- (NSString *)requestUrl {
    return @"/query/getCustomerInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
