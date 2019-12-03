//
//  BYBannerImageApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/29.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYBannerImageApi.h"

@implementation BYBannerImageApi
- (NSString *)requestUrl {
    return @"/bannerImage";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
