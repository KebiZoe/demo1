//
//  BYRepaymentApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BYRepaymentApi : BaseRequestApi
@property(nonatomic, strong) NSNumber *orderId;
@property(nonatomic, strong) NSNumber *loanNum;
@property(nonatomic, strong) NSNumber *repayType;
@end
