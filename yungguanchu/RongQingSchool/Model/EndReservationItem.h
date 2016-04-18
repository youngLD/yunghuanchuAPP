//
//  ReservationHistoryRecordItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EndReservationItem : NSObject

/**
 * 预约类型 k1ks 科一考试预约  k2ks 科二考试预约 k3ks 科三考试预约 k4ks 科三理论考试预约 k2fc 科二分车预约 k2px 科二培训预约 k3fc 科三分车预约 k3px 科三培训预约
 */
@property(strong,nonatomic) NSString *OrderType;

/**
 * 预约时间
 */
@property(strong,nonatomic) NSString *ReOrderDdate;

/**
 * 当前状态
 */
@property(strong,nonatomic) NSString *ReOrderState;

/**
 * 预约类型名称
 */
@property(strong,nonatomic) NSString *ReOrderType;

/**
 * 记录ID(主要存培训预约记录的id)
 */
@property(strong,nonatomic) NSString *SqlId;

/**
 * 数据库中的表
 */
@property(strong,nonatomic) NSString *SqlTable;

/**
 * 预约培训状态   2已完成未评价（2的时候才能退费）  3已评价 4 不允许评价 5退费中 6 退费审核不通过 7退费审核通过
 */
@property(strong,nonatomic) NSString *TranState;

/**
 * 能否退费
 */
@property(nonatomic) BOOL CanTF;

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
