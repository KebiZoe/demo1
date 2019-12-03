//
//  BYFindHistoryOrdersApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/22.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYFindHistoryOrdersApi.h"

@implementation BYFindHistoryOrdersApi
- (NSString *)requestUrl {
    return @"/query/findHistoryOrders";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
