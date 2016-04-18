//
//  MessageItem.h
//  RongQingSchool
//
//  Created by caitong on 15/9/7.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItem : NSObject

/**
 * 0:未读 1:已读
 */
@property(strong,nonatomic) NSString *nType;

/**
 *  消息id
 */
@property(strong,nonatomic) NSString *nid;

/**
 *  消息内容
 */
@property(strong,nonatomic) NSString *sMsg;
/**
 *  消息标题
 */
@property(strong,nonatomic) NSString *sName;

/**
 *  消息发布时间
 */
@property(strong,nonatomic) NSString *sendTime;

@property(nonatomic) BOOL isExpand;

@end
