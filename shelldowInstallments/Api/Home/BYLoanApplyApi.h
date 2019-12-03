//
//  BYLoanApplyApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/21.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BYLoanApplyApi : BaseRequestApi
@property(nonatomic, strong) NSNumber *periods;
@property(nonatomic, copy) NSString *amount;
@property(nonatomic, copy) NSString *unit;
@end
