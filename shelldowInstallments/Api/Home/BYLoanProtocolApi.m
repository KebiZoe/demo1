//
//  BYLoanProtocolApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/1/26.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYLoanProtocolApi.h"

@implementation BYLoanProtocolApi
- (NSString *)requestUrl {
    return @"/protocol/loan_protocol";
}
- (NSString *)baseUrl{
    
    if ([[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] && [[[BYSecurityManager sharedInstance] objectForKey:switchBase_URL_IP] boolValue] == YES) {
        NSString *baseurl = BASE_URL_TEST.copy;
        return [baseurl stringByReplacingOccurrencesOfString:@"8090" withString:@"8091"];
    }else{
        return BASE_URL;
    }
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{@"loanAmt":_loanAmt,
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
