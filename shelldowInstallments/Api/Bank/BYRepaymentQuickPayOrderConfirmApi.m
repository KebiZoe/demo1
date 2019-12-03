//
//  BYRepaymentQuickPayOrderConfirmApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYRepaymentQuickPayOrderConfirmApi.h"

@implementation BYRepaymentQuickPayOrderConfirmApi
- (NSString *)requestUrl {
    return @"/repayment/quickPayOrderConfirm";
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
