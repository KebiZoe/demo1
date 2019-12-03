//
//  RKTechFindLoanPeriodPlansApi.m
//  shelldowInstallments
//
//  Created by 曾祥宪 on 2019/5/20.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "RKTechFindLoanPeriodPlansApi.h"

@implementation RKTechFindLoanPeriodPlansApi
- (NSString *)requestUrl {
    return @"/query/findLoanPeriodPlans";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"orderId":_orderId,
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
