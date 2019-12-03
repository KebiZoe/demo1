//
//  WebViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "WebViewController.h"
#import "BYStartYysAuthApi.h"
#import "BYSecurityManager.h"
@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic) WKWebViewConfiguration *configuration;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubviews {
    [super initSubviews];
    [self initWKWebView];
    //初始化进度条
    [self initProgressView];
}
- (void)setupNavigationItems {
    [super setupNavigationItems];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(operationsOfNavigationItem:)];
    
}
- (void)operationsOfNavigationItem:(UINavigationItem *)sender{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self pop];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.configuration.userContentController addScriptMessageHandler:self name:@"ScanAction"];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.configuration.userContentController removeScriptMessageHandlerForName:@"ScanAction"];
}
//初始化webview
- (void)initWKWebView
{
    //进行配置控制器
    _configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    _configuration.userContentController = [WKUserContentController new];
    //调用JS方法
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    _configuration.preferences = preferences;
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:_configuration];
    //添加KVO监听网页加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    NSString *urlStr = self.receivedData[@"url"];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

//初始化进度条
-(void)initProgressView{
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    self.progressView.tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];;
    //self.progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if (object == self.webView && [keyPath isEqualToString:@"title"]){
        self.titleView.title = self.webView.title;
//        if ([self.titleView.title isEqualToString:@"运营商认证"]&&[self.webView.title isEqualToString:@"认证服务"]) {
//            [self pop];
//        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

#pragma mark - WKUIDelegate
//当把JS返回给控制器,然后弹窗就是这样设计的
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
    
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict =  message.body;
        if ([dict[@"body"] isEqualToString:@"YysAuthPop"]) {
            [QMUITips showLoadingInView:self.view];
            BYStartYysAuthApi *startYysAuthApi = [[BYStartYysAuthApi alloc] init];
            @WeakObj(self);
            [startYysAuthApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                @StrongObj(self);
                [QMUITips hideAllTipsInView:self.view];
                [self pop];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                @StrongObj(self);
                [self pop];
            }];
            
        }
    }
    
    
    
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - WKNavigationDelegate 页面跳转
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    /// 不要证书验证
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}
#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if([webView.URL.absoluteString hasSuffix:@"mobile_provision"]||[webView.URL.absoluteString hasSuffix:@"mobileprovision"]||[webView.URL.absoluteString hasSuffix:@"mobileProvision"]||[webView.URL.absoluteString hasSuffix:@"mobile-provision"]){
        decisionHandler(WKNavigationResponsePolicyCancel);
    }else{
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}
#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}
#pragma mark WKNavigation导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
#pragma mark WKWebView终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if ([webView.URL.absoluteString hasPrefix:@"itms-services://?action=download-manifest"]||[webView.URL.absoluteString hasSuffix:@"mobile_provision"]||[webView.URL.absoluteString hasSuffix:@"mobileprovision"]||[webView.URL.absoluteString hasSuffix:@"mobileProvision"]||[webView.URL.absoluteString hasSuffix:@"mobile-provision"]) {
        if ([[UIApplication sharedApplication]canOpenURL:webView.URL]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:webView.URL options:@{} completionHandler:nil];
            } else {
                diagnosticIgnored([[UIApplication sharedApplication]openURL:webView.URL]);
            }
        }
    }else{
        if ([webView.URL.scheme isEqualToString:@"weixin"]) {
            [self catchEventUrl:webView.URL];
            return;
        }
    }
}
- (void)catchEventUrl:(NSURL *)enventUrl{
    if ([enventUrl.host isEqualToString:@"wap"]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication]openURL:enventUrl options:@{} completionHandler:nil];
        } else {
            diagnosticIgnored([[UIApplication sharedApplication]openURL:enventUrl]);
        }
    }
}
#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if ([self.receivedData[@"isCareweeLink"] boolValue]) {
        NSString *cookieString = [NSString stringWithFormat:@"document.cookie='access_token=%@'", [[BYSecurityManager sharedInstance] objectForKey:token]];
        [webView evaluateJavaScript:cookieString completionHandler:nil];
    }else{
        if ([webView.URL.absoluteString hasPrefix:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb"]) {
            NSString *cookieString = [NSString stringWithFormat:@"document.cookie='Referer=%@'", @"www.rshtml.51nbapi.com://"];
            [webView evaluateJavaScript:cookieString completionHandler:nil];
        }
    }
}
#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}
#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end