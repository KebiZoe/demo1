//
//  BYRemindnoteApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/3/6.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYRemindnoteApi.h"

@implementation BYRemindnoteApi
- (NSString *)requestUrl {
    return @"/remindnote";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
