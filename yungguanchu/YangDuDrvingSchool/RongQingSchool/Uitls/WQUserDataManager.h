//
//  WQUserDataManager.h
//  caipiao
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 caitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQUserDataManager : NSObject
/**
 *    @brief    存储密码
 *
 *    @param     password     密码内容
 */
+(void)savePassWord:(NSString *)password;

/**
 *    @brief    读取密码
 *
 *    @return    密码内容
 */
+(id)readPassWord;

/**
 *    @brief    删除密码数据
 */
+(void)deletePassWord;
@end
