//
//  CoachDetailItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/4.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SoltlistItem : NSObject

/**
 *  时间段状态 0可预约 1已预约 2已请假
 */
@property(strong,nonatomic) NSString *TimeSoltState;

/**
 *  时间段
 */
@property(strong,nonatomic) NSString *Timesolt;

/**
 *  时间段id
 */
@property(strong,nonatomic) NSMutableArray *Timesoltid;

/**
 *  日期
 */
@property(strong,nonatomic) NSString *Orderdate;

/**
 *  预约时间段价格
 */
@property(strong,nonatomic) NSString *Price;

/**
 *  学时
 */
@property(strong,nonatomic) NSString *Xueshi;

/**
 *  追加预约日期
 */
@property(strong,nonatomic) NSString *ZjDate;

/**
 *  复训总人数
 */
@property(strong,nonatomic) NSString *fxrs;

/**
 *  复训剩余人数
 */
@property(strong,nonatomic) NSString *syrs;

/**
 *  是否选中
 */
@property(nonatomic) BOOL isSelected;

@end


@interface CoachDetailItem : NSObject

/**
 *  日期
 */
@property(strong,nonatomic) NSString *Orderdate;

/**
 *  SoltlistItem Array
 */
@property(strong,nonatomic) NSMutableArray *Soltlist;

@end
