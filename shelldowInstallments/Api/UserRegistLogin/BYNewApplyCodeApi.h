//
//  BYNewApplyCodeApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//  获取验证码

#import <YTKNetwork/YTKNetwork.h>

@interface BYNewApplyCodeApi : YTKRequest
@property(nonatomic, copy) NSString *phone;

@property(nonatomic, strong) NSString *type;
@end
