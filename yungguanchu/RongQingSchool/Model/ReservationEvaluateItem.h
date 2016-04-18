//
//  ReservationEvaluateItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationEvaluateItem : NSObject

/**
 * 评价星级/得分
 */
@property(strong,nonatomic) NSString *AppStars;

/**
 * 评价时间
 */
@property(strong,nonatomic) NSString *AppTime;

/**
 * 评价类型的代号 1:服务大厅评价  2科目二评价  3科目三评价  4预约培训评价
 */
@property(strong,nonatomic) NSString *AppTypeNum;

/**
 * 评价状态（0未评价 1已评价）
 */
@property(strong,nonatomic) NSString *ApprState;

/**
 * 评价类型（科一/二/三 培训预约）
 */
@property(strong,nonatomic) NSString *AppraiseType;

/**
 * 培训预约ID
 */
@property(strong,nonatomic) NSString *TranOrderId;

/**
 * 评价描述：好评/中评/差评
 */
@property(strong,nonatomic) NSString *appgrade;

/**具体含义不统一，所以不标注了，只能看文档*/
@property(strong,nonatomic) NSString *jdg;
@property(strong,nonatomic) NSString *sfg;
@property(strong,nonatomic) NSString *txxyqdg;
@property(strong,nonatomic) NSString *zpgang;
@property(strong,nonatomic) NSString *zxg;

/**
 * 科二/科三 教练员的姓名
 */
@property(strong,nonatomic) NSString *km23Jly;


@end
