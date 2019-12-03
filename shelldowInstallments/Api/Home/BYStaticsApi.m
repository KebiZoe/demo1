//
//  BYStaticsApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/30.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYStaticsApi.h"

@implementation BYStaticsApi
- (NSString *)baseUrl{
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] && [[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES) {
        NSString *baseurl = BASE_URL_TEST.copy;
        return [baseurl stringByReplacingOccurrencesOfString:@"8090" withString:@"8089"];
    }else{
        if([[[BYSecurityManager sharedInstance] objectForKey:merchantStatus] boolValue]){
            return BASE_URL;
        }else{
            return @"http://thirdpart.rank-tech.com";
        }
    }
}
- (NSString *)requestUrl {
    return @"/statics";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
             @"channel":_channel
             };
}
@end
