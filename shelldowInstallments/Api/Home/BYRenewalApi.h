//
//  BYRenewalApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/28.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYRenewalApi : BaseRequestApi
@property(nonatomic, strong) NSNumber *loanOrderId;
//@property(nonatomic, strong) NSNumber *loanNum;
@property(nonatomic, strong) NSNumber *orderRenewalAmt;
@end

NS_ASSUME_NONNULL_END
