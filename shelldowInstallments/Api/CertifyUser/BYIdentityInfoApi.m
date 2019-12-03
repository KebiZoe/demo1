//
//  BYIdentityInfoApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/19.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYIdentityInfoApi.h"

@implementation BYIdentityInfoApi
- (NSString *)requestUrl {
    return @"/certifyUser/identityInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"qq":_qq,
                       @"liveAddr":_liveAddr,
                       @"city":_city,
                       @"province":_province,
                       @"area":_area,
                       @"firstContactPhone":_firstContactPhone,
                       @"firstContactName":_firstContactName,
                       @"relationships1":_relationships1,
                       @"secondContactPhone":_secondContactPhone,
                       @"secondContactName":_secondContactName,
                       @"relationships2":_relationships2
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
