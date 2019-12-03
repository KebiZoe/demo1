//
//  BYLoanProtocolApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/1/26.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYLoanProtocolApi : BaseRequestApi
@property(nonatomic, copy) NSString *loanAmt;
@end

NS_ASSUME_NONNULL_END
