//
//  BYBaseViewModel.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/13.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZXXNavigationProtocol <NSObject>
@optional
- (void)vmpushViewControllerString:(NSString  *__nonnull)controllerString Data:(id __nullable)data;
- (void)vmpopToControllerString:(NSString  *__nullable)controllerString;
- (void)vmpopToRootController;
@end
#import "BaseRequestApi.h"
@interface BYBaseViewModel : NSObject
@property(nonatomic, strong, nullable) id<ZXXNavigationProtocol> naviDelegate;
- (void)vmpushVC:(NSString *__nonnull)vc Data:(id __nullable)data;
- (void)vmpopVC:(NSString *__nullable)vc;
- (void)vmpopToRootVc;
@end
/**
 基本请求回调
 
 @param request 得到请求结果的请求对象
 */
typedef void(^RequestBlock)(__kindof YTKRequest * _Nonnull request);

/**
 批量请求回调
 
 @param requestArray 得到请求结果的请求对象数组
 */
typedef void(^BatchBlock)(NSArray<__kindof YTKRequest *> * _Nonnull requestArray);

/**
 依赖的网络请求结果回调
 
 @param baseRequest 最基本的请求结果的请求对象
 @return 依赖API
 */
typedef __kindof YTKRequest *_Nullable(^ChainBlock_returnApi)(__kindof YTKRequest * _Nullable baseRequest);

/**
 依赖的网络请求结果回调
 
 @param baseRequest 最基本的请求结果的请求对象
 @return 请求数组
 */
typedef NSArray<__kindof YTKRequest *> *_Nullable(^ChainBlock_returnArrayApi)(__kindof YTKRequest * _Nullable baseRequest);
@interface BYBaseViewModel (Net)
/**
 最简单的API请求调用
 
 @param api 传递的API
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)startWithApi:(__kindof YTKRequest * _Nonnull)api completionBlockWithSuccess:(RequestBlock _Nullable )successBlock  failure:(RequestBlock _Nullable )failureBlock;
/**
 通过代理方法来调用API
 
 @param api api
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)starApi:(__kindof YTKRequest *_Nonnull)api requestFinished:(RequestBlock _Nullable )successBlock requestFailed:(RequestBlock _Nullable )failureBlock;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

/**
 批量的请求
 
 @param apiArray api数组
 @param successBlock 全部成功回调
 @param failureBlock 有失败回调
 @param failedRequestBlock 返回失败的API
 */
- (void)batchRequestWithRequestArray:(NSArray <__kindof YTKRequest *> *_Nonnull)apiArray startWithCompletionBlockWithSuccess:(BatchBlock _Nullable )successBlock failure:(BatchBlock _Nullable )failureBlock failedRequest:(RequestBlock _Nullable )failedRequestBlock;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

/**
 相互依赖的网络请求
 
 @param baseApi 基本API
 @param blockthenSecondApi 基本API成功回调，并且传入一个新的API
 @param blockSecond 新的API请求回调
 */
- (void)chainRequestWithBaseRequset:(__kindof YTKRequest *_Nonnull)baseApi successThenSecondRequest:(ChainBlock_returnApi _Nullable )blockthenSecondApi requestFinished:(RequestBlock _Nullable )blockSecond;
/**
 相互依赖的网络请求 blockthenApiArray
 
 @param baseApi 基本API
 @param blockthenApiArray 基本API成功回调，并且传入一组新的API
 @param blockArray 返回新的API数组
 @param failedblockArray 失败时返回新的API数组
 @param failedblock 返回失败的API
 */
- (void)chainRequestWithBaseRequset:(__kindof YTKRequest *_Nonnull)baseApi successThenRequestArray:(ChainBlock_returnArrayApi _Nullable )blockthenApiArray chainRequestFinished:(BatchBlock _Nullable )blockArray failed:(BatchBlock _Nullable )failedblockArray failedBaseRequest:(RequestBlock _Nullable )failedblock;

/**
 显示上次缓存的内容
 
 @param api api
 @param cacheBlock 显示上次缓存的内容
 @param successBlock 请求成功，刷新
 @param failureBlock 请求失败
 */
- (void)loadCacheDataWith:(__kindof YTKRequest * _Nonnull)api dataWithCache:(RequestBlock _Nullable )cacheBlock success:(RequestBlock _Nullable )successBlock failure:(RequestBlock _Nullable )failureBlock;
@end
