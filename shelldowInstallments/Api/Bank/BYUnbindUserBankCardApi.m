//
//  BYUnbindUserBankCardApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYUnbindUserBankCardApi.h"

@implementation BYUnbindUserBankCardApi
- (NSString *)requestUrl {
    return @"/certifyUser/unbindUserBankCard";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
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
