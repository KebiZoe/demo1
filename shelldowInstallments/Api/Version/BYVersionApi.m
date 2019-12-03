//
//  BYVersionApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/30.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYVersionApi.h"
#import "AFNetworking.h"
@implementation BYGetAppVerSionApi
- (NSString *)baseUrl{
    return @"https://release.rank-tech.com";
}
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/app/checkupdate/%@/ios/%@/%@",Release_TeamId,[BYGetAppVerSionApi getBundleID],[BYGetAppVerSionApi getLocalAppVersionBuild]];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}
- (void)startWithCompletionBlockWithSuccess:(SUCCESSBlock)success failure:(FAILDBlock)failure{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"success"] boolValue]==true) {
//            BYAPPVersionModel *appVersionModel = [[BYAPPVersionModel alloc] initWithDictionary:request.responseObject[@"data"]];
//            success(appVersionModel.version.installUrl.copy);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure(request.error);
    }];
}
+ (NSString*) getLocalAppVersionBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
//获取BundleID

+ (NSString*) getBundleID{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
@end
