//
//  BYModifyPasswordApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/17.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//  修改密码

#import "BaseRequestApi.h"

@interface BYModifyPasswordApi : BaseRequestApi
@property(nonatomic, copy) NSString *oldPassword;
@property(nonatomic, copy) NSString *password;
@end
