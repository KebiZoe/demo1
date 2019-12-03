//
//  BYCheckUserLoanStatusApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/27.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYCheckUserLoanStatusApi.h"

@implementation BYCheckUserLoanStatusApi
- (NSString *)requestUrl {
    return @"/query/checkUserLoanStatus";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
