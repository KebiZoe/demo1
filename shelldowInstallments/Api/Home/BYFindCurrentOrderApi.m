//
//  BYFindCurrentOrderApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYFindCurrentOrderApi.h"

@implementation BYFindCurrentOrderApi
- (NSString *)requestUrl {
    return @"/query/findCurrentOrder";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
