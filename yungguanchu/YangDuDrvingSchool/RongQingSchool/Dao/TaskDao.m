//
//  TaskDao.m
//  BaseStationManage
//
//  Created by SarnathAir on 14-7-29.
//  Copyright (c) 2014年 SarnathAir. All rights reserved.
//

#import "TaskDao.h"
#import "Utils.h"

@implementation TaskDao

///**
// *  保存新照的照片以及照片信息
// *
// *  @param item
// */
//-(void)savePhoto:(TaskModel *)item
//{
////    //查看是否有同一个基站的同一个方向的信息
////    NSString *sql = [NSString stringWithFormat:@"select count(*) from Newtasks where stationID = '%@' and direction = %@",item.stationID,item.direction];
////    
////    FMResultSet *rs = [self executeQuery:sql];
////    NSInteger count = 0;
////    while (rs.next) {
////        count = [rs intForColumnIndex:0];
////    }
////    
////    
////    //有,则删除
////    if(count)
////    {
////        NSString *sql2 = [NSString stringWithFormat:@"delete from Newtasks where stationID = '%@' and direction = '%@'",item.stationID,item.direction];
////        if(![self executeUpdate:sql2])
////        {
////            CLog(@"删除浏览失败");
////        }
////    }
//    NSString *sql3 = [NSString stringWithFormat:@"insert into Newtasks (\
//                      stationID,\
//                      stationName,\
//                      employeeId,\
//                      imageName,\
//                      longitude,\
//                      latitude,\
//                      direction,\
//                      tokenTime,\
//                      stationCode,\
//                      area)\
//                      values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
//                      item.stationID,
//                      item.stationName,
//                      item.employeeId,
//                      item.imageName,
//                      item.longitude,
//                      item.latitude,
//                      item.direction,
//                      item.tokenTime,
//                      item.stationCode,
//                      item.area];
//    
//    if(![self executeUpdate:sql3])
//    {
//        CLog(@"插入新任务失败");
//    }
//
//}
//
///**
// *  任务上传成功后保存下来
// *
// *  @param item
// */
//-(void)saveOldPhoto:(TaskModel *)item
//{
//    NSString *sql3 = [NSString stringWithFormat:@"insert into Oldtasks (\
//                      stationID,\
//                      stationName,\
//                      employeeId,\
//                      imageName,\
//                      longitude,\
//                      latitude,\
//                      direction,\
//                      tokenTime,\
//                      stationCode,\
//                      area)\
//                      values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
//                      item.stationID,
//                      item.stationName,
//                      item.employeeId,
//                      item.imageName,
//                      item.longitude,
//                      item.latitude,
//                      item.direction,
//                      item.tokenTime,
//                      item.stationCode,
//                      item.area];
//    
//    if(![self executeUpdate:sql3])
//    {
//        CLog(@"插入上传的任务失败");
//    }
//    
//}
//
///**
// *  查询任务
// *
// *  @param table 从哪个表中查询：Newtasks or Oldtasks
// *
// *  @return 结果
// */
//-(NSMutableArray *)selectNewtasks:(NSString *)table
//{
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
//    NSString *sql = [NSString stringWithFormat:@"select * from %@  order by tokenTime desc",table];
//    
//    FMResultSet *frs = [self executeQuery:sql];
//    while(frs.next)
//    {
//        TaskModel *taskModel = [[TaskModel alloc] init];
//        taskModel.stationID = [frs stringForColumn:@"stationID"];
//        taskModel.stationName = [frs stringForColumn:@"stationName"];
//        taskModel.employeeId = [frs stringForColumn:@"employeeId"];
//        taskModel.imageName = [frs stringForColumn:@"imageName"];
//        taskModel.longitude = [frs stringForColumn:@"longitude"];
//        taskModel.latitude = [frs stringForColumn:@"latitude"];
//        taskModel.direction = [frs stringForColumn:@"direction"];
//        taskModel.tokenTime = [frs stringForColumn:@"tokenTime"];
//        taskModel.stationCode = [frs stringForColumn:@"stationCode"];
//        taskModel.area = [frs stringForColumn:@"area"];
//        
//        [arr addObject:taskModel];
//    }
//    
//    return arr;
//}
//
///**
// *  删除某一个任务
// *
// *  @param item  要删除任务
// *  @param table 从哪个表中查询：Newtasks or Oldtasks
// *  @param b 是否删图片
// */
//-(void)removeTask:(TaskModel *)item fromTable:(NSString *)table removeImage:(BOOL)b
//{
//    //通过基站id和拍照时间定位一个任务
//    NSString *sql2 = [NSString stringWithFormat:@"delete from %@ where stationID = '%@' and tokenTime = '%@'",table,item.stationID,item.tokenTime];
//    if(![self executeUpdate:sql2])
//    {
//        CLog(@"删除失败");
//    }
//    else
//    {
//        if(b)
//        {
//            //图片路径
//            NSString *fullPath = [NSString stringWithFormat:@"%@/%@",[FileUtil getDirectoryPath:@"photos"],item.imageName];
//            NSString *smallFile_fullPath = [NSString stringWithFormat:@"%@/%@",[FileUtil getDirectoryPath:@"photos"],[NSString stringWithFormat:@"small_%@",item.imageName]];
//            
//            NSFileManager *fm = [[NSFileManager alloc] init];
//            if([fm fileExistsAtPath:fullPath])
//            {
//                NSError *error = nil;
//                [fm removeItemAtPath:fullPath error:&error];
//                [fm removeItemAtPath:smallFile_fullPath error:nil];
//                if(error) [Utils showMessage:@"删除图片文件失败"];
//            }
//        }
//        
//    }
//}
//
///**
// *  默认保留20条
// */
//-(void)resetDatabase
//{
//    //查找20条以外的图片名称的sql
//    NSString *sql2 = @"select imageName from Oldtasks where id not in (select id from (select id from Oldtasks order by id desc) limit 20)";
//    FMResultSet *frs = [self executeQuery:sql2];
//    
//    //删除20条以外的照片
//    while(frs.next)
//    {
//        //图片路径
//        NSString *fullPath = [NSString stringWithFormat:@"%@/%@",[FileUtil getDirectoryPath:@"photos"],[frs stringForColumn:@"imageName"]];
//         NSString *smallFile_fullPath = [NSString stringWithFormat:@"%@/%@",[FileUtil getDirectoryPath:@"photos"],[NSString stringWithFormat:@"small_%@",[frs stringForColumn:@"imageName"]]];
//        
//        NSFileManager *fm = [[NSFileManager alloc] init];
//        if([fm fileExistsAtPath:fullPath])
//        {
//            NSError *error = nil;
//            [fm removeItemAtPath:fullPath error:&error];
//            [fm removeItemAtPath:smallFile_fullPath error:nil];
//            if(error) [Utils showMessage:@"删除图片文件失败"];
//        }
//        
//    }
//    
//    
//    //删除数据库记录
//    NSString *sql = @"delete from Oldtasks where id not in (select * from (select id from Oldtasks order by id desc) limit 20)";
//    
//    if(![self executeUpdate:sql])
//    {
//        CLog(@"删除多余的失败");
//    }
//}
//
///**
// *  保存历史拍照基站
// *
// *  @param item
// */
//-(void)saveHistoryStation:(TaskModel *)item
//{
//    NSString *sql = [NSString stringWithFormat:@"select count(*) as count from HistoryStation where stationID = '%@'",item.stationID];
//    
//    NSInteger count = 0;
//    FMResultSet *fr = [self executeQuery:sql];
//    while(fr.next)
//    {
//        count = [fr intForColumn:@"count"];
//    }
//    
//    //原来历史表中存在，更新他的信息
//    if(count)
//    {
//        NSString *sql2 = [NSString stringWithFormat:@"update HistoryStation set \
//                          stationName = '%@',\
//                          employeeId = '%@',\
//                          imageName = '%@',\
//                          longitude = '%@',\
//                          latitude = '%@',\
//                          direction = '%@',\
//                          tokenTime = '%@',\
//                          stationCode = '%@',\
//                          area = '%@' where \
//                          stationID = '%@'",
//                          item.stationName,
//                          item.employeeId,
//                          item.imageName,
//                          item.longitude,
//                          item.latitude,
//                          item.direction,
//                          item.tokenTime,
//                          item.stationCode,
//                          item.area,
//                          item.stationID];
//        if(![self executeUpdate:sql2])
//        {
//            CLog(@"更新历史表失败");
//        }
//    }
//    else
//    {
//        NSString *sql3 = [NSString stringWithFormat:@"insert into HistoryStation (\
//                          stationID,\
//                          stationName,\
//                          employeeId,\
//                          imageName,\
//                          longitude,\
//                          latitude,\
//                          direction,\
//                          tokenTime,\
//                          stationCode,\
//                          area)\
//                          values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
//                          item.stationID,
//                          item.stationName,
//                          item.employeeId,
//                          item.imageName,
//                          item.longitude,
//                          item.latitude,
//                          item.direction,
//                          item.tokenTime,
//                          item.stationCode,
//                          item.area];
//        
//        if(![self executeUpdate:sql3])
//        {
//            CLog(@"插入历史表失败");
//        }
//    }
//}


@end
