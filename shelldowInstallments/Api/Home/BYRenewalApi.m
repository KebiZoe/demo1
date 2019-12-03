//
//  BYRenewalApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/28.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYRenewalApi.h"

@implementation BYRenewalApi
- (NSString *)requestUrl {
    return @"/repayment/renewal";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{@"loanOrderId":_loanOrderId,
             @"loanNum":@(1),
             @"orderRenewalAmt":_orderRenewalAmt
             };
}
@end
