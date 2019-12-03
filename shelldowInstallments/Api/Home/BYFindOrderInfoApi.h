//
//  BYFindOrderInfoApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/12/4.
//  Copyright © 2018 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYFindOrderInfoApi : BaseRequestApi
@property(nonatomic, strong) NSNumber *orderId;
@end

NS_ASSUME_NONNULL_END
