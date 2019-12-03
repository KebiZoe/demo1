//
//  BYGetBankInfoByUserIdApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetBankInfoByUserIdApi.h"

@implementation BYGetBankInfoByUserIdApi
- (NSString *)requestUrl {
    return @"/query/getBankInfoByUserId";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
