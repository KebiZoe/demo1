//
//  BYLoginoutApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/17.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYLoginoutApi.h"

@implementation BYLoginoutApi
- (NSString *)requestUrl {
    return @"/User/loginOut";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end