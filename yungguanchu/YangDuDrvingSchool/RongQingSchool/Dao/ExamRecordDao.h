//
//  ExamRecordDao.h
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "BaseDao.h"
#import "ExamRecordModel.h"

@interface ExamRecordDao : BaseDao

/**
 *  插入一条考试记录
 *
 *  @param item
 */
-(void)insertExamRecord:(ExamRecordModel *)item;

/**
 *  查询考试记录
 *
 *  @return
 */
-(NSMutableArray *)selectExamRecors;

/*
 * 清空表数据
 */
-(void)deleteExamRecords;

@end
