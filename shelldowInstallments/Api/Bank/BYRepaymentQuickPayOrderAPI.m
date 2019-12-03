//
//  BYRepaymentQuickPayOrderAPI.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYRepaymentQuickPayOrderAPI.h"

@implementation BYRepaymentQuickPayOrderAPI
- (NSString *)requestUrl {
    return @"/repayment/quickPayOrder";
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
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
