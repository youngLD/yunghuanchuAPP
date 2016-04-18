//
//  WebRequest.m
//  VKT
//
//  Created by SarnathAir on 13-11-13.
//  Copyright (c) 2013年 SarnathAir. All rights reserved.
//

#import "WebRequest.h"
#import "JSONKit.h"
#import "Utils.h"


NSString* const  NetWebServiceRequestErrorDomain = @"NetWebServiceRequestErrorDomain";
@implementation WebRequest

/**
 *  web 请求公共类,在dealloc里请执行clearDelegatesAndCancel方法
 *
 *  @param action       URL的后缀
 *  @param parameterDic 字典参数
 */
-(void)requestPostWithAction:(NSString *)action WithParameter:(NSDictionary *)parameterDic successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock
{
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    
    //如果url有中文，需要url编码
    NSString * strURL = [NSString stringWithFormat:@"%@%@",SERVER_IP,action];
    
    self.requestForm.shouldAttemptPersistentConnection = NO;
    
    /*
    //封装请求表单
    NSString *key = nil;
    NSEnumerator *myEnumerator3=[parameterDic keyEnumerator];
    //拼接URL
    while (key = [myEnumerator3 nextObject])
    {
        NSString *value = [parameterDic objectForKey:key];
        strURL = [NSString stringWithFormat:@"%@%@=%@&",strURL,key,value];
    }
    
    //url编码防止中文
    strURL=[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * reqURL = [[NSURL alloc] initWithString:strURL];
    
    //请求对象
    self.requestForm = [[ASIFormDataRequest alloc] initWithURL:reqURL];
     */
    
    strURL=[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
     //封装请求表单
     NSString *key = nil;
     NSEnumerator *myEnumerator3=[parameterDic keyEnumerator];
     while (key=[myEnumerator3 nextObject])
     {
         NSString *value = [parameterDic objectForKey:key];
         [self.requestForm setPostValue:value forKey:key];
     }
    
    for(NSDictionary *imageDic in self.imageAry){
        //封装请求表单
        NSString *key2 = nil;
        NSEnumerator *myEnumerator2=[imageDic keyEnumerator];
        while (key2=[myEnumerator2 nextObject])
        {
            NSString *imagePath = [imageDic objectForKey:key2];
            [self.requestForm setFile:imagePath forKey:key2];
        }
    }
    
    
    //超时时间
    self.requestForm.timeOutSeconds = 15.0f;
    
    //避免多次发送请求
    self.requestForm.shouldAttemptPersistentConnection = NO;

    //请求委托
    self.requestForm.delegate = self;
    
    [self startAsynchronous];
}

/**
 *  web get 请求公共类,在dealloc里请执行clearDelegatesAndCancel方法
 *
 *  @param action       URL的后缀
 *  @param parameterDic 字典参数
 */
-(void)requestGetWithAction:(NSString *)action WithParameter:(NSDictionary *)parameterDic successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock
{
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    
    //如果url有中文，需要url编码
    NSString * strURL = [NSString stringWithFormat:@"%@%@",SERVER_IP,action];
    
    self.requestForm.shouldAttemptPersistentConnection = NO;
    
    
     //封装请求表单
     NSString *key = nil;
     NSEnumerator *myEnumerator3=[parameterDic keyEnumerator];
     //拼接URL
     while (key = [myEnumerator3 nextObject])
     {
         NSString *value = [parameterDic objectForKey:key];
         strURL = [NSString stringWithFormat:@"%@%@=%@&",strURL,key,value];
     }
     
     //url编码防止中文
     strURL=[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSURL * reqURL = [[NSURL alloc] initWithString:strURL];
     
     //请求对象
     self.requestForm = [[ASIFormDataRequest alloc] initWithURL:reqURL];
    self.requestForm.requestMethod = @"GET";
    self.requestForm.delegate = self;
    
     /*
    
    strURL=[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    //封装请求表单
    NSString *key = nil;
    NSEnumerator *myEnumerator3=[parameterDic keyEnumerator];
    while (key=[myEnumerator3 nextObject])
    {
        NSString *value = [parameterDic objectForKey:key];
        [self.requestForm setPostValue:value forKey:key];
    }
    */
    
    //超时时间
    self.requestForm.timeOutSeconds = 15.0f;
    
    //避免多次发送请求
    self.requestForm.shouldAttemptPersistentConnection = NO;
    
    //请求委托
    self.requestForm.delegate = self;
    
    [self startAsynchronous];
}

//异步请求
-(void)startAsynchronous
{
    [self.requestForm startAsynchronous];
}

//同步请求
-(void)startSynchronous
{
    [self.requestForm startSynchronous];
}

//开始请求
-(void)requestStarted:(ASIFormDataRequest *)request
{
    //显示状态栏的网络请求状态
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //请求开始
    if (_delegate && [_delegate respondsToSelector:@selector(startWebRequest:)])
    {
        //需要显示加载框
        if(self.showProgressHub)
        {
            //委托是控制器的情况
            if([self.delegate respondsToSelector:@selector(viewDidLoad)])
            {
                UIViewController *vc = (UIViewController *)self.delegate;
                [Utils addProgressHUBInView:vc.view textInfo:@"loading" delegate:nil];
            }
            //位图是一个视图
            else
            {
                UIView *v = (UIView *)self.delegate;
                [Utils addProgressHUBInView:v textInfo:@"loading" delegate:nil];
            }
        }
        [self.delegate startWebRequest:self];
    }
}

//请求完成
-(void)requestFinished:(ASIFormDataRequest *)request
{
    CLog(@"%@",request.requestHeaders);
    CLog(@"%@",request.responseHeaders);
    //隐藏加载框
    if(self.showProgressHub)
    {
        //委托是控制器的情况
        if([self.delegate respondsToSelector:@selector(viewDidLoad)])
        {
            UIViewController *vc = (UIViewController *)self.delegate;
            [Utils removeProgressHUB:vc.view];
        }
        //位图是一个视图
        else
        {
            UIView *v = (UIView *)self.delegate;
            [Utils removeProgressHUB:v];
        }
    }
    
    //隐藏状态栏的网络请求状态
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	//获取状态码
    int statusCode = [request responseStatusCode];
    CLog(@"statusCode:%d",statusCode);
    
    NSError *error = nil;
    
	// Use when fetching text data
	NSString *responseString =[request responseString];
    CLog(@"%@",responseString);
	
    //请求成功
    if (statusCode >= 200 && statusCode < 300)
    {
        NSError *dataError = nil;
        NSDictionary *dic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionNone error:&dataError];
        
        //解析没有错误，说明返回返回数据正常
        if(!dataError)
        {
            //数据正常
//            [_delegate finishedWebRequest:self resultDic:dic];
            if([[dic objectForKey:@"Success"] intValue] == 1){
                self.successBlock(dic);
            }
            else{
                NSString *msg = [dic objectForKey:@"Msg"];
                error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,msg);
                [self requestError:error];
            }
        }
        ////解析错误，说明返回返回数据错误
        else
        {
            CLog(@"resultCode:%d",statusCode);
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,@"serverData.error");
            [self requestError:error];
        }
        
    }
    else
    {
        
        //已经移动的文件并且常被包含在定位头信息中指定新的地址信息
        if(statusCode >= 300 && statusCode < 400)
        {
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,request.responseStatusMessage);
        }
        //客户端有错误
        else if(statusCode >= 400 && statusCode < 500)
        {
            
            if(statusCode == 403)
            {
                error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,@"无权限");
            }
            else if(statusCode == 404)
            {
                error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,@"资源不存在");
            }
        }
        //服务器异常
        else if(statusCode >= 500 && statusCode < 600)
        {
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, statusCode,@"server.error");
        }
        [self requestError:error];
    }
    
}

//请求失败
-(void)requestFailed:(ASIFormDataRequest *)request
{
    //隐藏加载框
    if(self.showProgressHub)
    {
        //委托是控制器的情况
        if([self.delegate respondsToSelector:@selector(viewDidLoad)])
        {
            UIViewController *vc = (UIViewController *)self.delegate;
            [Utils removeProgressHUB:vc.view];
        }
        //位图是一个视图
        else
        {
            UIView *v = (UIView *)self.delegate;
            [Utils removeProgressHUB:v];
        }
    }
    
    int statusCode = [request responseStatusCode];
    CLog(@"statusCode:%d",statusCode);
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError *error = ERROR_DICTINFO(NetWebServiceRequestErrorDomain, request.error.code, request.error.userInfo);
 
    if (error.code == ASIRequestTimedOutErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestTimedOutErrorType, @"net.timeout");
    }
    else if (error.code == ASIConnectionFailureErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"requestFailed");
    }
    else if(error.code == ASIAuthenticationErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"auth.failed");
    }
    else
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"requestFailed");
    }
    
    [self requestError:error];
}

//请求失败共通处理
-(void)requestError:(NSError*)error
{
    //网络错误、请求失败
    NSString *errorString = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        [Utils showMessage:errorString];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:errorString,@"errorDescription", nil];
        self.failedBlock(dic);
}

-(void)clearDelegatesAndCancel{
    [self.requestForm clearDelegatesAndCancel];
}

@end
