//
//  BYFindLoaningOrderApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYFindLoaningOrderApi.h"

@implementation BYFindLoaningOrderApi
- (NSString *)requestUrl {
    return @"/query/findLoaningOrder";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
