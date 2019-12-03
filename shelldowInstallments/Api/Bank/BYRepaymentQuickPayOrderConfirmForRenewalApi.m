//
//  BYRepaymentQuickPayOrderConfirmForRenewalApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYRepaymentQuickPayOrderConfirmForRenewalApi.h"

@implementation BYRepaymentQuickPayOrderConfirmForRenewalApi
- (NSString *)requestUrl {
    return @"/repayment/quickPayOrderConfirmForRenewal";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"bankCard":_bankCard,
                       @"bankPhone":_bankPhone,
                       @"username":_username,
                       @"idCard":_idCard,
                       @"payChannel":_payChannel,
                       @"repayType":_repayType,
                       @"loanNum":_loanNum?:@(1),
                       @"orderId":_orderId,
                       @"verifyCode":_verifyCode,
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
