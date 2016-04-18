//
//  ExamRecordModel.h
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamRecordModel : NSObject

/**
 *  id
 */
@property(strong,nonatomic) NSString *id_;

/**
 *  用户id
 */
@property(strong,nonatomic) NSString *userID;

/**
 *  科目：1科目一   2科目四 3货车 4客车 5摩托车
 */
@property(nonatomic) int subject_type;

/**
 *  分数
 */
@property(strong,nonatomic) NSString *score;

/**
 *  考试用时
 */
@property(strong,nonatomic) NSString *time;

/**
 *  考试时间
 */
@property(strong,nonatomic) NSString *date;

@end
