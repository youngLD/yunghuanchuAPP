//
//  PxSoltListItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PxSoltListItem : NSObject
/**
 * 能否退约描述
 */
@property(strong,nonatomic) NSString *PxCanCancel;

/**
 * 退约提示
 */
@property(strong,nonatomic) NSString *PxCancelMsg;

/**
 * 具体时间
 */
@property(strong,nonatomic) NSString *PxDetailTime;

/**
 * 该时间段(预约记录）状态   能否退约  0：能够退约 1：:不可退约
 */
@property(strong,nonatomic) NSString *PxSoltState;

/**
 * 培训预约记录id
 */
@property(strong,nonatomic) NSString *TranOrderId;

/**
 * 是否是复训 1是复训  0是计时班
 */
@property(strong,nonatomic) NSString *sffx;

/**
 * 教练车号
 */
@property(strong,nonatomic) NSString *jlch;

/**
 * 教练电话
 */
@property(strong,nonatomic) NSString *jldh;

/**
 * 教练姓名
 */
@property(strong,nonatomic) NSString *jlxm;
@end
