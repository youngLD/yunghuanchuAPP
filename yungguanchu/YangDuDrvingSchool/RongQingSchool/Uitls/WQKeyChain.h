//
//  WQKeyChain.h
//  caipiao
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 caitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQKeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
