//
//  BYRepaymentRepaymentChannelListApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYRepaymentRepaymentChannelListApi.h"

@implementation BYRepaymentRepaymentChannelListApi
- (NSString *)requestUrl {
    return @"/repayment/repaymentChannelList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
@end
