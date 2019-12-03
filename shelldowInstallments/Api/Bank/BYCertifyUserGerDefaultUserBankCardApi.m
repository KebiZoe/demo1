//
//  BYCertifyUserGerDefaultUserBankCardApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYCertifyUserGerDefaultUserBankCardApi.h"

@implementation BYCertifyUserGerDefaultUserBankCardApi
- (NSString *)requestUrl {
    return @"/certifyUser/gerDefaultUserBankCard";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
