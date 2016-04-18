//
//  ExamRecordDao.m
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ExamRecordDao.h"

@implementation ExamRecordDao

/**
 *  插入一条考试记录
 *
 *  @param item
 */
-(void)insertExamRecord:(ExamRecordModel *)item{
    NSString *sql = [NSString stringWithFormat:@"insert into exam_record (\
                     userID, \
                     subject_type, \
                     score, \
                     time, \
                     date)\
                     values('%@',%d,'%@','%@','%@')",
                     item.userID,
                     item.subject_type,
                     item.score,
                     item.time,
                     item.date];
    if(![self executeUpdate:sql]){
        CLog(@"插入考试记录失败");
    }
}

/**
 *  查询考试记录
 *
 *  @return
 */
-(NSMutableArray *)selectExamRecors{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql;
    if([UserInfo shareUserInfo].KemuTag == 1)
        sql = [NSString stringWithFormat:@"select * from exam_record where subject_type != 2 order by id  desc"];
    else
        sql = [NSString stringWithFormat:@"select * from exam_record where subject_type = 2 order by id desc"];
    
    FMResultSet *frs = [self executeQuery:sql];
    while (frs.next) {
        ExamRecordModel *item = [[ExamRecordModel alloc] init];
        item.id_ = [frs stringForColumn:@"id"];
        item.userID = [frs stringForColumn:@"userID"];
        item.subject_type = [frs intForColumn:@"subject_type"];
        item.score = [frs stringForColumn:@"score"];
        item.time = [frs stringForColumn:@"time"];
        item.date = [frs stringForColumn:@"date"];
        
        [ary addObject:item];
    }
    
    return ary;
}

/*
 * 清空表数据
 */
-(void)deleteExamRecords{
    NSString *sql;
    if([UserInfo shareUserInfo].KemuTag == 1)
        sql = [NSString stringWithFormat:@"delete from exam_record where subject_type != 2"];
    else
        sql = [NSString stringWithFormat:@"delete from exam_record where subject_type = 2"];
    if(![self executeUpdate:sql]){
        CLog(@"清空考试纪录失败了呢");
    }
    else{
        CLog(@"清空考试纪录成功了");
    }
}

@end
