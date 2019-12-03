//
//  BYIdCardInfoAuthIOSApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/18.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BYIdCardInfoAuthIOSApi : BaseRequestApi
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *idCard;
@property(nonatomic, strong) UIImage *front;
@property(nonatomic, strong) UIImage *back;
@property(nonatomic, copy) NSString *sex;
@property(nonatomic, copy) NSString *cardAddr;
@property(nonatomic, copy) NSString *nation;
@property(nonatomic, copy) NSString *validStart;
@property(nonatomic, copy) NSString *validEnd;
@end
