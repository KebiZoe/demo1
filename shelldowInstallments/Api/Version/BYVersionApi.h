//
//  BYVersionApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/30.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import <Foundation/Foundation.h>
@import YTKNetwork;
NS_ASSUME_NONNULL_BEGIN
typedef void (^SUCCESSBlock)(id response);
typedef void (^FAILDBlock)(NSError *error);
@interface BYGetAppVerSionApi : YTKRequest
- (void)startWithCompletionBlockWithSuccess:(SUCCESSBlock __nullable)success failure:(FAILDBlock __nullable)failure;
@end

NS_ASSUME_NONNULL_END
