//
//  BYGetHomeInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetHomeInfoApi.h"

@implementation BYGetHomeInfoApi
- (NSString *)requestUrl {
    return @"/home/getHomeInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
