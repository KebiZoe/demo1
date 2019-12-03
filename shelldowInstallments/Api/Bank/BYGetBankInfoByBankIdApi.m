//
//  BYGetBankInfoByBankIdApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetBankInfoByBankIdApi.h"

@implementation BYGetBankInfoByBankIdApi
- (NSString *)requestUrl {
    return @"/query/getBankInfoByBankId";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"bankId":_bankId,
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
