//
//  BYGetLoanDetailApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/28.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetLoanDetailApi.h"

@implementation BYGetLoanDetailApi
- (NSString *)requestUrl {
    return @"/query/getLoanDetail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument{
    return @{@"loanAmount":_loanAmount};
}
@end
