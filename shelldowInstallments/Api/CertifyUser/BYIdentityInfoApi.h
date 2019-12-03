//
//  BYIdentityInfoApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/19.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BYIdentityInfoApi : BaseRequestApi
@property(nonatomic, copy) NSString *qq;
@property(nonatomic, copy) NSString *liveAddr;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *province;
@property(nonatomic, copy) NSString *area;
@property(nonatomic, copy) NSString *firstContactPhone;
@property(nonatomic, copy) NSString *firstContactName;
@property(nonatomic, copy) NSString *relationships1;
@property(nonatomic, copy) NSString *secondContactPhone;
@property(nonatomic, copy) NSString *secondContactName;
@property(nonatomic, copy) NSString *relationships2;
@end
