//
//  BYSecurityManager.h
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2019/2/12.
//  Copyright © 2019 曾祥宪. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface BYSecurityManager : NSObject
+ (instancetype)sharedInstance;
- (nullable id)objectForKey:(NSString *)key;
- (void)setObject:(nullable id)value forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (BOOL)removeAll;
@end

NS_ASSUME_NONNULL_END
