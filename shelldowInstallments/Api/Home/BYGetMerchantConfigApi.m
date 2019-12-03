//
//  BYGetMerchantConfigApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/10/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYGetMerchantConfigApi.h"

@implementation BYGetMerchantConfigApi
- (NSString *)baseUrl{
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] && [[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES) {
        NSString *baseurl = BASE_URL_TEST.copy;
        return [baseurl stringByReplacingOccurrencesOfString:@"8090" withString:@"8089"];
    }else{
        
        return [super baseUrl];
    }
}
- (NSString *)requestUrl {
    return @"/getMerchantConfig";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    return @{
             @"owner":_owner?:@"",
             };
}
@end
