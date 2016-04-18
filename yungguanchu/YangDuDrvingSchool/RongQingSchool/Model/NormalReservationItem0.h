//
//  NormalReservationItem0.h
//  RongQingSchool
//
//  Created by caitong on 15/9/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalReservationItem0 : NSObject

/**
 *  车型
 */
@property(strong,nonatomic) NSString *chexing;

/**
 *  分车计划说明
 */
@property(strong,nonatomic) NSString *fencheRemark;


/**
 *  分车计划时间
 */
@property(strong,nonatomic) NSString *fencheTime;

/**
 *  是否已经预约（1代表这一条已经被预约了）
 */
@property(nonatomic) NSInteger isYY;

/**
 *  计划剩余人数
 */
@property(strong,nonatomic) NSString *leftNum;

/**
 *  计划总人数
 */
@property(strong,nonatomic) NSString *maxNum;

/**
 *  2没有用
 */
@property(nonatomic) NSInteger ntype;

/**
 *  计划类型
 */
@property(strong,nonatomic) NSString *sType;

/**
 *  计划id
 */
@property(strong,nonatomic) NSString *xid;

@end
