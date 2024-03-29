//
//  BYCertifyBankCardInfoApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/20.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BYCertifyBankCardInfoApi : BaseRequestApi
@property(nonatomic, copy) NSString *bankCard;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *bankMobile;
@property(nonatomic, copy) NSString *idCard;
@property(nonatomic, copy) NSString *validateCode;
@end
