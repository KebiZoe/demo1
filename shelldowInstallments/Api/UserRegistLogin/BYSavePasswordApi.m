//
//  BYSavePasswordApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYSavePasswordApi.h"

@implementation BYSavePasswordApi
- (NSString *)requestUrl {
    return @"/processUser/savePassword";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"password":_password
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
