//
//  BYFindOrderInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/12/4.
//  Copyright © 2018 曾祥宪. All rights reserved.
//

#import "BYFindOrderInfoApi.h"

@implementation BYFindOrderInfoApi
- (NSString *)requestUrl {
    return @"/query/findOrderInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"orderId":_orderId,
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
