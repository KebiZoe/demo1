//
//  BYLoanApplyApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYLoanApplyApi.h"

@implementation BYLoanApplyApi
- (NSString *)requestUrl {
    return @"/loan/Apply";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"amount":_amount,
                       @"periods":_periods,
                       @"unit":_unit
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
