//
//  DonwloadRequest.h
//  RongQingSchool
//
//  Created by caitong on 15/9/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "VideoItem.h"
@interface DownloadRequest : NSObject

@property(strong,nonatomic) ASINetworkQueue *netWorkQueue;

+(DownloadRequest *)shareInstanse;

/**
 *  添加一个下载到队列中
 *
 *  @param video video item
 */
- (void)downVideo:(VideoItem *)video progressDelegate:(id)progress;

/**
 *  暂停下载
 *
 *  @param video video item
 */
- (void)pauseDownload:(VideoItem *)video;

/**
 *  视频是否正在下载
 *
 *  @param video video
 *
 *  @return
 */
- (BOOL)isVideoDownload:(VideoItem *)video;

@end
