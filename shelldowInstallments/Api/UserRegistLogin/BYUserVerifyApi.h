//
//  BYUserVerifyApi.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/16.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface BYUserVerifyApi : YTKRequest
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *channelCode;
//@optional
@property(nonatomic, copy) NSString *password;
@end
