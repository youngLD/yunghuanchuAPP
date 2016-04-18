//
//  ExamReservationItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentReservationItem : NSObject

/**
 * 预约时间
 */
@property(strong,nonatomic) NSString *ReOrderDdate;

/**
 * 当前状态
 */
@property(strong,nonatomic) NSString *ReOrderState;

/**
 * 预约类型 k1ks 科一考试预约  k2ks 科二考试预约 k3ks 科三考试预约 k4ks 科三理论考试预约 k2fc 科二分车预约 k2px 科二培训预约 k3fc 科三分车预约 k3px 科三培训预约
 */
@property(strong,nonatomic) NSString *OrderType;

/**
 * 预约类型名称
 */
@property(strong,nonatomic) NSString *ReOrderType;

@property(strong,nonatomic) NSString *OrderTypeName;
@property(strong,nonatomic) NSString *OrderState;
@property(strong,nonatomic) NSString *OrderDate;

/**
 * 能否退费
 */
@property(nonatomic) BOOL CanTF;

@end
