//
//  GeneralWebRequest.h
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebRequest.h"

typedef void(^SuccessResponeBlock)(NSDictionary *resultDic);

typedef void(^FailedResponeBlock)(NSDictionary *resultDic);

@interface GeneralWebRequest : NSObject

@property(strong,nonatomic) WebRequest *webRequest;

/**
 *  登录
 *
 *  @param userName 用户名
 *  @param pwd      密码
 *  @param code     验证码
 */
-(void)requestLogin:(NSString *)userName passWord:(NSString *)pwd successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;

/**
 *  发送验证码
 *
 *  @param number 手机号
 */
-(void)requestPhoneVerifyCodePhone:(NSString *)number successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;

/**
 *  请求版本信息
 *
 *  @param successBlock 
 *  @param failedBlock
 */
-(void)requestVersionInfoSuccessBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;
//获取首页详情
-(void)GetHomePageInfoWith:(NSDictionary *)Parameter SuccessBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;
//获取公告详情
-(void)getNewsDetialInfoWithParameter:(NSDictionary *)Parameter SuccessBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;
@end
