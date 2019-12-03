//
//  BYUploadContactsApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/30.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYUploadContactsApi.h"

@implementation BYUploadContactsApi
- (NSString *)requestUrl {
    return @"/contact/uploadContacts";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{@"contacts":_contacts};
    [dict addEntriesFromDictionary:dd];
    return dict;
}
@end
