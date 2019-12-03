//
//  WebViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BYBaseViewController.h"

@import WebKit;
@interface WebViewController : BYBaseViewController
@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;
// 长链接
//@property(nonatomic, assign) BOOL isCareweeLink;
//receivedData 为字典类型，表示需要打开的网址
/*
 @{
 @"isCareweeLink":@(),
 @"url":@""
 }
 */
@end
