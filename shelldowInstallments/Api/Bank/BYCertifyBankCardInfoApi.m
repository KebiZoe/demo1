//
//  BYCertifyBankCardInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYCertifyBankCardInfoApi.h"

@implementation BYCertifyBankCardInfoApi
- (NSString *)requestUrl {
    return @"/certifyUser/bankCardInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"bankCard":_bankCard,
                       @"name":_name,
                       @"bankMobile":_bankMobile,
                       @"idCard":_idCard,
                       @"validateCode":_validateCode
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
