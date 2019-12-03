//
//  BYNewApplyCodeApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYNewApplyCodeApi.h"

@implementation BYNewApplyCodeApi

- (NSString *)requestUrl {
    return @"/User/newApplyCode";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    if (_type.length>0) {
        return @{@"phone":_phone,
                 @"type":_type
                 };
    }else{
        return @{
                 @"phone":_phone
                 };
    }
}
@end
