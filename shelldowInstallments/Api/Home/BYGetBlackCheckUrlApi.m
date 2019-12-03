//
//  BYGetBlackCheckUrlApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/12/12.
//  Copyright © 2018 曾祥宪. All rights reserved.
//

#import "BYGetBlackCheckUrlApi.h"

@implementation BYGetBlackCheckUrlApi
- (NSString *)requestUrl {
    return @"/getUrl";
}
- (NSString *)baseUrl{
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] && [[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES) {
        NSString *baseurl = BASE_URL_TEST.copy;
        return [baseurl stringByReplacingOccurrencesOfString:@"8090" withString:@"8089"];
    }else{
        
        return @"http://thirdpart.rank-tech.com";
    }
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{@"phone":_phone,
                       @"environment":_environment
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
