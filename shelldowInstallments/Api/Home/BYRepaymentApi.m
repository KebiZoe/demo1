//
//  BYRepaymentApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYRepaymentApi.h"

@implementation BYRepaymentApi
- (NSString *)requestUrl {
    return @"/repayment/repayment";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"loanNum":_loanNum,
                       @"orderId":_orderId,
                       @"repayType":_repayType
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
