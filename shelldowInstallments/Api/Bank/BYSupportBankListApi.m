//
//  BYSupportBankListApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/10/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYSupportBankListApi.h"

@implementation BYSupportBankListApi
- (NSString *)requestUrl {
    return @"/supportBankList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
