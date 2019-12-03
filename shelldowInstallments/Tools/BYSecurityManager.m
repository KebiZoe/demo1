//
//  BYSecurityManager.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import "BYSecurityManager.h"
@interface BYSecurityManager()
@property(nonatomic, strong) NSMutableDictionary *dictM;
@end
@implementation BYSecurityManager
static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (instancetype)sharedInstance
{
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(NSString *)pathDocumentDirectoryWithfileNameComponent:(NSString *)fileName{
    //获取沙河路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}
- (void)setObject:(nullable id)value forKey:(NSString *)key{
    [self checkDictM];
    if (value == nil) {
        NSException *exception = [NSException exceptionWithName:NSGenericException reason:@"不能为空" userInfo:nil];
        @throw exception;
    }
    [_dictM setObject:value forKey:key];
    [self updataToFile];
}
- (nullable id)objectForKey:(NSString *)key{
    [self checkDictM];
    if (![_dictM containsObjectForKey:key]) {
        return nil;
    }
    return [_dictM objectForKey:key];
}
- (void)removeObjectForKey:(NSString *)key{
    [self checkDictM];
    if (![_dictM containsObjectForKey:key]) {
        return;
    }
    [_dictM removeObjectForKey:key];
    [self updataToFile];
}

- (void)checkDictM{
    NSString *archiveFilePath = [self pathDocumentDirectoryWithfileNameComponent:@"securityInfo"];
    if (_dictM==nil) {
        if (![[NSFileManager defaultManager]fileExistsAtPath:archiveFilePath]) {
            _dictM = [NSMutableDictionary dictionary];
        }else{
            if (IOS12_SDK_ALLOWED) {
                NSData *data = [NSData dataWithContentsOfFile:archiveFilePath];
                if (data) {
                    _dictM = [[NSKeyedUnarchiver unarchivedObjectOfClass:NSMutableDictionary.class fromData:data error:nil] mutableCopy];
                }else{
                    NSException *exception = [NSException exceptionWithName:NSFileHandleOperationException reason:@"找不到文件路径" userInfo:nil];
                    @throw exception;
                }
            }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                _dictM = [[NSKeyedUnarchiver unarchiveObjectWithFile:archiveFilePath] mutableCopy];
#pragma clang diagnostic pop
            }
        }
    }
}
- (void)updataToFile{
    NSString *archiveFilePath = [self pathDocumentDirectoryWithfileNameComponent:@"securityInfo"];
    if (IOS12_SDK_ALLOWED) {
        NSError *err;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_dictM requiringSecureCoding:YES error:&err];
        [data writeToFile:archiveFilePath atomically:YES];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [NSKeyedArchiver archiveRootObject:_dictM toFile:archiveFilePath];
#pragma clang diagnostic pop
    }
}
- (BOOL)removeAll{
    NSString *archiveFilePath = [self pathDocumentDirectoryWithfileNameComponent:@"securityInfo"];
    _dictM = nil;
    return [[NSFileManager defaultManager] removeItemAtPath:archiveFilePath error:nil];
    
}
@end
