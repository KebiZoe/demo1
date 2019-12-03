//
//  BYModifyPasswordApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/17.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYModifyPasswordApi.h"

@implementation BYModifyPasswordApi
- (NSString *)requestUrl {
    return @"/processUser/modifyPassword";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"password":_password,
                       @"oldPassword":_oldPassword
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
