//
//  WebRequest.h
//  VKT
//
//  Created by SarnathAir on 13-11-13.
//  Copyright (c) 2013年 SarnathAir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "WebMacro.h"

typedef void(^SuccessResponeBlock)(NSDictionary *resultDic);

typedef void(^FailedResponeBlock)(NSDictionary *resultDic);

//网络异常枚举
typedef enum _NetworkRequestErrorType {
    NetRequestConnectionFailureErrorType = 1,
    NetRequestTimedOutErrorType = 2,
    NetRequestError = 3
} NetworkRequestErrorType;

@protocol WebRequestDelegate;

@interface WebRequest : NSObject<ASIHTTPRequestDelegate>
{
    
}
//请求对象
@property(strong,nonatomic)ASIFormDataRequest * requestForm;

@property(assign,nonatomic)id<WebRequestDelegate> delegate;

/** 是否显示加载框*/
@property(nonatomic) BOOL showProgressHub;

//用于分区不同的请求
@property(assign,nonatomic) NSInteger row;

//用于分区不同的请求2
@property(assign,nonatomic) NSInteger tag;

@property(strong,nonatomic) SuccessResponeBlock successBlock;
@property(strong,nonatomic) FailedResponeBlock failedBlock;

@property(strong,nonatomic) NSArray *imageAry;

/**
 *  web 请求公共类,在dealloc里请执行clearDelegatesAndCancel方法
 *
 *  @param action       URL的后缀
 *  @param parameterDic 字典参数
 */
-(void)requestPostWithAction:(NSString *)action WithParameter:(NSDictionary *)parameterDic successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;

/**
 *  web get 请求公共类,在dealloc里请执行clearDelegatesAndCancel方法
 *
 *  @param action       URL的后缀
 *  @param parameterDic 字典参数
 */
-(void)requestGetWithAction:(NSString *)action WithParameter:(NSDictionary *)parameterDic successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock;

//异步请求
-(void)startAsynchronous;

//同步请求
-(void)startSynchronous;

-(void)clearDelegatesAndCancel;
@end

//委托类
@protocol WebRequestDelegate <NSObject>

@optional
-(void)startWebRequest:(WebRequest *)webRequest;

@required
-(void)finishedWebRequest:(WebRequest *)webRequest resultDic:(NSDictionary *)resultDic;
-(void)faildWebRequest:(WebRequest *)webRequest didRequestError:(NSError *)error;

@end
