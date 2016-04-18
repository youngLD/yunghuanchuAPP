//
//  NormalReservationItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/4.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalReservationItem : NSObject

/**
 *  车辆id
 */
@property(strong,nonatomic) NSString *CLId;

/**
 *  车牌号
 */
@property(strong,nonatomic) NSString *Cph;

/**
 *  教龄
 */
@property(strong,nonatomic) NSString *Jl;

/**
 *  教练电话
 */
@property(strong,nonatomic) NSString *Jldh;

/**
 *  教练合格率
 */
@property(strong,nonatomic) NSString *Jlhgl;

/**
 *  教练id
 */
@property(strong,nonatomic) NSString *Jlid;

/**
 *  教练评分
 */
@property(strong,nonatomic) NSString *Jlpf;

/**
 *  教练头像
 */
@property(strong,nonatomic) NSString *Jlpic;

/**
 *  教练所在中队
 */
@property(strong,nonatomic) NSString *Jlsszd;

/**
 *  教练性别
 */
@property(strong,nonatomic) NSString *Jlxb;

/**
 *  教练姓名
 */
@property(strong,nonatomic) NSString *Jlxm;

/**
 *   钱
 */
@property(strong,nonatomic) NSString *OrderPrice;

/**
 *  剩余
 */
@property(strong,nonatomic) NSString *OrderShengyuNum;

/**
 *  "剩余名额
 */
@property(strong,nonatomic) NSString *Syme;

@end
