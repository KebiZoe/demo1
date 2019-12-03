//
//  BYBaseViewModel.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/13.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYBaseViewModel.h"
@interface BYBaseViewModel ()<YTKRequestDelegate,YTKChainRequestDelegate>
@property (copy,nonatomic,nullable)RequestBlock successBlock;

@property (copy,nonatomic,nullable)RequestBlock failureBlock;

@property (copy,nonatomic,nullable)BatchBlock chainArrayBlock;

@property (copy,nonatomic,nullable)BatchBlock chainFailedArrayBlock;

@property (copy,nonatomic,nullable)RequestBlock chainFailedBlck;
@end
@implementation BYBaseViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)vmpushVC:(NSString *__nonnull)vc Data:(id __nullable)data{
    if ([self.naviDelegate respondsToSelector:@selector(vmpushViewControllerString:Data:)]) {
        [self.naviDelegate vmpushViewControllerString:vc Data:data];
    }
}
- (void)vmpopVC:(NSString *__nullable)vc{
    if ([self.naviDelegate respondsToSelector:@selector(vmpopToControllerString:)]) {
        [self.naviDelegate vmpopToControllerString:vc];
    }
}
- (void)vmpopToRootVc{
    if ([self.naviDelegate respondsToSelector:@selector(vmpopToRootController)]) {
        [self.naviDelegate vmpopToRootController];
    }
}
@end
@implementation BYBaseViewModel (Net)
#pragma mark —— 网络请求
#pragma mark - 基本的网络请求处理
- (void)startWithApi:(__kindof YTKRequest *)api completionBlockWithSuccess:(RequestBlock)successBlock failure:(RequestBlock)failureBlock {
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        
        [self pritfReturnCodeStatus:request];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

- (void)starApi:(__kindof YTKRequest *)api requestFinished:(RequestBlock)successBlock requestFailed:(RequestBlock)failureBlock{
    [api start];
    
    self.successBlock = successBlock;
    
    self.failureBlock = failureBlock;
    
    api.delegate = self;
}

- (void)requestFinished:(__kindof YTKRequest *)request {
    if (self.successBlock!=nil) {
        self.successBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
- (void)requestFailed:(__kindof YTKRequest *)request {
    if (self.failureBlock!=nil) {
        self.failureBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
#pragma mark - 批量网络请求处理
- (void)batchRequestWithRequestArray:(NSArray <__kindof YTKRequest *> *)apiArray startWithCompletionBlockWithSuccess:(BatchBlock)successBlock failure:(BatchBlock)failureBlock failedRequest:(RequestBlock)failedRequestBlock{
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apiArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (successBlock!=nil) {
            successBlock(requests);
        }
        __kindof YTKRequest * lastRequest = requests.lastObject;
        [self pritfReturnCodeStatus:lastRequest];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (failureBlock!=nil) {
            failureBlock(requests);
        }
        __kindof YTKRequest *failedRq = batchRequest.failedRequest;
        if (failedRequestBlock!=nil) {
            failedRequestBlock(failedRq);
        }
        [self pritfReturnCodeStatus:failedRq];
    }];
}


#pragma mark - 相互依赖的网络请求
- (void)chainRequestWithBaseRequset:(__kindof YTKRequest *)baseApi successThenSecondRequest:(ChainBlock_returnApi)blockthenSecondApi requestFinished:(RequestBlock)blockSecond{
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    @WeakObj(self);
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        @StrongObj(self);
        __kindof YTKRequest *secondReq = blockthenSecondApi(baseRequest);
        if(secondReq!=nil){
            [chainRequest addRequest:secondReq callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
                @StrongObj(self);
                if (blockSecond!=nil) {
                    blockSecond(baseRequest);
                }
                [self pritfReturnCodeStatus:baseRequest];
            }];
        }else{
            [self pritfReturnCodeStatus:baseRequest];
        }
        
    }];
    [chainReq start];
}

- (void)chainRequestWithBaseRequset:(__kindof YTKRequest *)baseApi successThenRequestArray:(ChainBlock_returnArrayApi)blockthenApiArray chainRequestFinished:(BatchBlock)blockArray failed:(BatchBlock)failedblockArray failedBaseRequest:(RequestBlock)failedblock{
    
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        NSArray <__kindof YTKRequest *> *arrRequest = blockthenApiArray(baseRequest);
        if (arrRequest!=nil) {
            [arrRequest enumerateObjectsUsingBlock:^(__kindof YTKRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [chainRequest addRequest:obj callback:nil];
            }];
            self.chainArrayBlock = blockArray;
            self.chainFailedArrayBlock = failedblockArray;
            self.chainFailedBlck = failedblock;
        }
    }];
    chainReq.delegate = self;
    [chainReq start];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(__kindof YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    __kindof YTKBaseRequest *lastApi = chainRequest.requestArray.lastObject;
    if (self.chainArrayBlock!=nil) {
        self.chainArrayBlock(arrayM);
    }
    [self pritfReturnCodeStatus:lastApi];
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(__kindof YTKBaseRequest*)request {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    if (self.chainFailedArrayBlock!=nil) {
        self.chainFailedArrayBlock(arrayM);
    }
    if (self.chainFailedBlck!=nil) {
        self.chainFailedBlck(request);
    }
    [self pritfReturnCodeStatus:request];
    // some one of request is failed
}

#pragma 显示上次缓存的内容
- (void)loadCacheDataWith:(__kindof YTKRequest *)api dataWithCache:(RequestBlock)cacheBlock success:(RequestBlock)successBlock failure:(RequestBlock)failureBlock{
    if ([api loadCacheWithError:nil]) {
        if (cacheBlock!=nil) {
            cacheBlock(api);
        }
    }
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    } failure:^(__kindof YTKBaseRequest *request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

#pragma mark - 打印回调状态
- (void)pritfReturnCodeStatus:(__kindof YTKRequest *)request{
    [self showErrorInfoOnKeyWindowHudWithRequest:request];
}
- (void)showErrorInfoOnKeyWindowHudWithRequest:(__kindof YTKRequest *)request{
    if ([request.responseObject[@"code"] integerValue]!=100&&request.responseObject) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ErrorInfo" ofType:@"plist"];
        NSDictionary *error_dit = [NSDictionary dictionaryWithContentsOfFile:filePath];
        if (error_dit) {
            
        }
        ZXXLog(@"%@",error_dit[request.responseObject[@"code"]]);
    }else{
    }
}
@end
