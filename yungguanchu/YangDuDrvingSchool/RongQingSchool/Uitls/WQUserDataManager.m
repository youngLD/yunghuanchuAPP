//
//  WQUserDataManager.m
//  caipiao
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 caitong. All rights reserved.
//

#import "WQUserDataManager.h"
#import "WQKeyChain.h"

@implementation WQUserDataManager
static NSString * const KEY_IN_KEYCHAIN = @"com.RongQingScholl.allinfo";
static NSString * const KEY_PASSWORD = @"com.RongQingScholl.password";

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [WQKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[WQKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [WQKeyChain delete:KEY_IN_KEYCHAIN];
}
@end
