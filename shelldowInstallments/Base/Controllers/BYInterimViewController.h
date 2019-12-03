//
//  BYInterimViewController.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/12.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYBaseViewController.h"

@interface BYInterimViewController : BYBaseViewController
///底层的滑动视图
@property(nonatomic, weak ,readonly) UIScrollView *slideView;
/**
 过渡视图
 */
@property(nonatomic, weak, readonly) UIView *interimView;

@property(nonatomic, strong) RACSubject *tapInterimViewSubject;
@end
