//
//  DonwloadRequest.m
//  RongQingSchool
//
//  Created by caitong on 15/9/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "DownloadRequest.h"

@implementation DownloadRequest

static DownloadRequest *downloadRequest;
+(DownloadRequest *)shareInstanse{
    if(!downloadRequest){
        downloadRequest = [[DownloadRequest alloc] init];
        downloadRequest.netWorkQueue  = [[ASINetworkQueue alloc] init];
        [downloadRequest.netWorkQueue reset];
        [downloadRequest.netWorkQueue setShowAccurateProgress:YES];
        [downloadRequest.netWorkQueue go];
    }
    return downloadRequest;
}

#pragma mark MyBookDelegate method

/**
 *  添加一个下载到队列中
 *
 *  @param video video item
 */
- (void)downVideo:(VideoItem *)video progressDelegate:(id)progress{
    
    //初始化Documents路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //初始化临时文件路径
    NSString *folderPath = [path stringByAppendingPathComponent:@"temp"];
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断temp文件夹是否存在
    BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
    
    if (!fileExists) {//如果不存在说创建,因为下载时,不会自动创建文件夹
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *videoName = [[video.videoUrl componentsSeparatedByString:@"/"] lastObject];
    //初始下载路径
    NSURL *url = [NSURL URLWithString:video.videoUrl];
    //设置下载路径
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    //设置ASIHTTPRequest代理
    request.delegate = self;
    //初始化保存ZIP文件路径
    NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",videoName]];
    //初始化临时文件路径
    NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/%@.temp",videoName]];
    //设置文件保存路径
    [request setDownloadDestinationPath:savePath];
    //设置临时文件路径
    [request setTemporaryFileDownloadPath:tempPath];
    //设置进度条的代理,
    [request setDownloadProgressDelegate:progress];
    //设置是是否支持断点下载
    [request setAllowResumeForFileDownloads:YES];
    [request setTimeOutSeconds:300];
    //设置基本信息
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:video,@"video",nil]];
     [request setShouldContinueWhenAppEntersBackground:YES];
    //添加到ASINetworkQueue队列去下载
    [self.netWorkQueue addOperation:request];
    CLog(@"%lu",(unsigned long)self.netWorkQueue.operations.count);
}

/**
 *  暂停下载
 *
 *  @param video video item
 */
- (void)pauseDownload:(VideoItem *)video {
    //查找暂停的对象
    for (ASIHTTPRequest *request in [self.netWorkQueue operations]) {
        
        VideoItem *item = [request.userInfo objectForKey:@"video"];//查看userinfo信息
        if ([item.uid isEqualToString:video.uid]) {
            //暂停匹配对象
            [request clearDelegatesAndCancel];
        }
    }
}

/**
 *  视频是否正在下载
 *
 *  @param video video
 *
 *  @return
 */
- (BOOL)isVideoDownload:(VideoItem *)video{
    //查找暂停的对象
    for (ASIHTTPRequest *request in [self.netWorkQueue operations]) {
        
        VideoItem *item = [request.userInfo objectForKey:@"video"];//查看userinfo信息
        if ([item.uid isEqualToString:video.uid]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate method

//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
    CLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    VideoItem *item = [request.userInfo objectForKey:@"video"];//查看userinfo信息
    CLog(@"%@:%.2fM",item.name,request.contentLength/1000.0/1000.0);

}
//ASIHTTPRequestDelegate,下载完成时,执行的方法
- (void)requestFinished:(ASIHTTPRequest *)request {
    VideoItem *item = [request.userInfo objectForKey:@"video"];//查看userinfo信息
    CLog(@"%@下载完成",item.name);
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Download_Task_Message object:nil];
    
}
//ASIHTTPRequestDelegate,下载失败
- (void)requestFailed:(ASIHTTPRequest *)request {
    int statusCode = [request responseStatusCode];
    CLog(@"statusCode:%d",statusCode);
    NSString *errorString;
    
    if (statusCode == ASIRequestTimedOutErrorType)
    {
        errorString = @"net.timeout";
    }
    else if (statusCode == ASIConnectionFailureErrorType)
    {
        errorString = @"requestFailed";
    }
    else if(statusCode == ASIAuthenticationErrorType)
    {
        errorString = @"auth.failed";
    }
    else
    {
        errorString = @"requestFailed";
    }
    
    
    VideoItem *item = [request.userInfo objectForKey:@"video"];//查看userinfo信息
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Utils getLocalized:errorString] message:[NSString stringWithFormat:@"%@下载失败，请重新下载",item.name] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    CLog(@"%@下载失败",item.name);
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Download_Task_Message object:nil];
}

@end
