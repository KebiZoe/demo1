//
//  RegisterApi.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseRequestApi.h"
#import "AppDelegate.h"
#import "BYSecurityManager.h"
@implementation BaseRequestApi
- (id)requestArgument {
    NSMutableDictionary *dict = @{
                                  @"access_token":[[BYSecurityManager sharedInstance]objectForKey:token]?:@"",
                                  }.mutableCopy;
    return dict;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return @{
             @"access_token":[[BYSecurityManager sharedInstance]objectForKey:token]?:@"",
             };
}
- (id)responseJSONObject{
    id responseJSONObject = [super responseJSONObject];
    if ([responseJSONObject isKindOfClass:[NSDictionary class]]) {
        if ([responseJSONObject[@"code"] isEqualToString:@"010011"]) {
            dispatch_async_on_main_queue(^{
                [QMUITips showWithText:responseJSONObject[@"message"]];
                [[BYSecurityManager sharedInstance]removeAll];
                AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appdelegate chooseRootViewController:@"BYLoginViewController"];
            });
        }
    }
    return responseJSONObject;
}
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if(TARGET_IPHONE_SIMULATOR){
                NSDate *currentDate = [NSDate date];
                NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYY-MM-dd"];
                NSString *folder=[dateformatter stringFromDate:currentDate];
                NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:folder];
                BOOL isDir = YES;
                NSFileManager *manager = [NSFileManager defaultManager];
                if (![manager fileExistsAtPath:folderPath isDirectory:&isDir]) {
                    [manager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                NSString *fileName = [NSString stringWithFormat:@"%@.txt",NSStringFromClass(self.class)];
                NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
                if (![manager fileExistsAtPath:filePath]) { //如果不存在
                    [manager createFileAtPath:filePath contents:nil attributes:nil];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
                    NSString *stringData = [NSString stringWithFormat:@"\n发送时间:%@\n 网络请求:%@\n requestHeader:%@\n ResponceJson:%@\n",datestr,[request description],[request.requestHeaderFieldValueDictionary description], [request.responseObject description]];
                    stringData = [stringData stringByReplacingOccurrencesOfString:@"<null>" withString:@"null"];
                    [[stringData dataUsingEncoding:NSUTF8StringEncoding] writeToFile:filePath atomically:YES];
                }else{
                    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                    [fileHandle seekToEndOfFile];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
                    NSString *stringData = [NSString stringWithFormat:@"\n发送时间:%@\n 网络请求%@\n requestHeader:%@\n ResponceJson:%@\n",datestr,[request description],[request.requestHeaderFieldValueDictionary description], [request.responseObject description]];
                    stringData = [stringData stringByReplacingOccurrencesOfString:@"<null>" withString:@"null"];
                    [fileHandle writeData:[stringData dataUsingEncoding:NSUTF8StringEncoding]]; //追加写入数据
                    [fileHandle closeFile];
                }
            }
        });
        if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
            if ([request.responseObject[@"code"]isEqualToString:@"000000"]||[request.responseObject[@"code"]isEqualToString:@"000205"]||[request.responseObject[@"code"]isEqualToString:@"000005"]||[request.responseObject[@"code"]isEqualToString:@"000002"]||[request.responseObject[@"code"]isEqualToString:@"010033"]||[request.responseObject[@"code"]isEqualToString:@"000140"]||[request.responseObject[@"code"]isEqualToString:@"030022"]||[request.responseObject[@"code"]isEqualToString:@"030002"]||[request.responseObject[@"code"] isEqualToString:@"010013"]||[request.responseObject[@"code"]isEqualToString:@"000016"]) {
                success(request);
            }else{
                if(request.responseObject[@"message"]!=NULL){
                    UIViewController *vc = [QMUIHelper visibleViewController];
                    [QMUITips showWithText:request.responseObject[@"message"]];
                    if ([QMUITips toastInView:vc.view]!=nil) {
                        [QMUITips hideAllTipsInView:vc.view];
                    }
                }
            }
        }else{
            success(request);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.error.localizedDescription isEqualToString:@"The network connection was lost."]||[request.error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]) {
            [QMUITips showWithText:@"网络连接失败"];
        }else{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if(TARGET_IPHONE_SIMULATOR){
                    NSDate *currentDate = [NSDate date];
                    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYY-MM-dd"];
                    NSString *folder=[dateformatter stringFromDate:currentDate];
                    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:folder];
                    BOOL isDir = YES;
                    NSFileManager *manager = [NSFileManager defaultManager];
                    if (![manager fileExistsAtPath:folderPath isDirectory:&isDir]) {
                        [manager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    NSString *fileName = [NSString stringWithFormat:@"%@.txt",NSStringFromClass(self.class)];
                    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
                    if (![manager fileExistsAtPath:filePath]) { //如果不存在
                        [manager createFileAtPath:filePath contents:nil attributes:nil];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
                        NSString *stringData = [NSString stringWithFormat:@"\n发送时间:%@\n 网络请求:%@\n requestHeader:%@\n Error:%@\n ResponceJson:%@\n",datestr,[request description],[request.requestHeaderFieldValueDictionary description], [request.error description], request.responseObject?[request.responseObject description]:@"null"];
                        stringData = [stringData stringByReplacingOccurrencesOfString:@"<null>" withString:@"null"];
                        [[stringData dataUsingEncoding:NSUTF8StringEncoding] writeToFile:filePath atomically:YES];
                    }else{
                        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                        [fileHandle seekToEndOfFile];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
                        NSString *stringData = [NSString stringWithFormat:@"\n发送时间:%@\n 网络请求%@\n requestHeader:%@\n Error:%@\n ResponceJson:%@\n",datestr,[request description],[request.requestHeaderFieldValueDictionary description], [request.error description], request.responseObject?[request.responseObject description]:@"null"];
                        stringData = [stringData stringByReplacingOccurrencesOfString:@"<null>" withString:@"null"];
                        [fileHandle writeData:[stringData dataUsingEncoding:NSUTF8StringEncoding]]; //追加写入数据
                        [fileHandle closeFile];
                    }
                }
            });
        }
        UIViewController *vc = [QMUIHelper visibleViewController];
        if ([QMUITips toastInView:vc.view]!=nil) {
            [QMUITips hideAllTipsInView:vc.view];
        }
        failure(request);
    }];
}
@end
