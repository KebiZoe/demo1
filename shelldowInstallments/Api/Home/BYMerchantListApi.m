//
//  BYMerchantListApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/22.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYMerchantListApi.h"

@implementation BYMerchantListApi

- (NSString *)requestUrl {
    return @"/merchant/getMerchantList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument{
    return @{@"type":_type};
}
@end
