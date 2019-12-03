//
//  BYGetBlackCheckUrlApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/12/12.
//  Copyright © 2018 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYGetBlackCheckUrlApi : BaseRequestApi
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *environment;
@end

NS_ASSUME_NONNULL_END
