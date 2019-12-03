//
//  BYRepaymentQuickPayOrderAPI.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYRepaymentQuickPayOrderAPI : BaseRequestApi
@property(nonatomic, copy) NSString *bankCard;
@property(nonatomic, copy) NSString *bankPhone;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *idCard;
@property(nonatomic, strong) NSNumber *payChannel;
@property(nonatomic, strong) NSNumber *repayType;
@property(nonatomic, strong) NSNumber *loanNum;
@property(nonatomic, strong) NSNumber *orderId;
@end

NS_ASSUME_NONNULL_END
