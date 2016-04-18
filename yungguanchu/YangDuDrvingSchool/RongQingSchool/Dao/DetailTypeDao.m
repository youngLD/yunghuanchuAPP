//
//  DetailTypeDao.m
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "DetailTypeDao.h"

@implementation DetailTypeDao

//章节练习
-(NSMutableArray *)selectAllChapter:(SubjectType)type{
    
    if(type == 1){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=1)   as count0, \
                         (select count(*) from question_library where detail_type=1)    as count1, \
                         (select count(*) from question_library where detail_type=2)    as count2, \
                         (select count(*) from question_library where detail_type=3)    as count3, \
                         (select count(*) from question_library where detail_type=4)    as count4"];
        

        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4]];
        }
        return arr;
        
    }
    else if(type == 3 || type == 4 || type == 5){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=1 or subject_type=%d)    as count0, \
                         (select count(*) from question_library where detail_type=1)                        as count1, \
                         (select count(*) from question_library where detail_type=2)                        as count2, \
                         (select count(*) from question_library where detail_type=3)                        as count3, \
                         (select count(*) from question_library where detail_type=4)                        as count4, \
                         (select count(*) from question_library where subject_type=%d)                      as count5",type,type];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5]];
        }
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=2)   as  count0, \
                         (select count(*) from question_library where detail_type=5)    as  count1, \
                         (select count(*) from question_library where detail_type=6)    as  count2, \
                         (select count(*) from question_library where detail_type=7)    as  count3, \
                         (select count(*) from question_library where detail_type=8)    as  count4, \
                         (select count(*) from question_library where detail_type=9)    as  count5, \
                         (select count(*) from question_library where detail_type=10)   as  count6, \
                         (select count(*) from question_library where detail_type=11)   as  count7"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            NSString *count6 = [frs1 stringForColumn:@"count6"];
            NSString *count7 = [frs1 stringForColumn:@"count7"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5,count6,count7]];
        }
        return arr;
    }
}

//我的收藏章节列表
-(NSMutableArray *)selectMyCollectionChapter:(SubjectType)type{
    if(type == 1){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=1 and collect_flag = 1)   as count0, \
                         (select count(*) from question_library where detail_type=1 and collect_flag = 1)    as count1, \
                         (select count(*) from question_library where detail_type=2 and collect_flag = 1)    as count2, \
                         (select count(*) from question_library where detail_type=3 and collect_flag = 1)    as count3, \
                         (select count(*) from question_library where detail_type=4 and collect_flag = 1)    as count4"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4]];
        }
        return arr;
        
    }
    else if(type == 3 || type == 4 || type == 5){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where (subject_type=1 or subject_type=%d) and collect_flag = 1)  as count0, \
                         (select count(*) from question_library where detail_type=1 and collect_flag = 1)                        as count1, \
                         (select count(*) from question_library where detail_type=2 and collect_flag = 1)                        as count2, \
                         (select count(*) from question_library where detail_type=3 and collect_flag = 1)                        as count3, \
                         (select count(*) from question_library where detail_type=4 and collect_flag = 1)                        as count4, \
                         (select count(*) from question_library where subject_type=%d and collect_flag = 1)                      as count5",type,type];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5]];
        }
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=2 and collect_flag = 1)   as  count0, \
                         (select count(*) from question_library where detail_type=5 and collect_flag = 1)    as  count1, \
                         (select count(*) from question_library where detail_type=6 and collect_flag = 1)    as  count2, \
                         (select count(*) from question_library where detail_type=7 and collect_flag = 1)    as  count3, \
                         (select count(*) from question_library where detail_type=8 and collect_flag = 1)    as  count4, \
                         (select count(*) from question_library where detail_type=9 and collect_flag = 1)    as  count5, \
                         (select count(*) from question_library where detail_type=10 and collect_flag = 1)   as  count6, \
                         (select count(*) from question_library where detail_type=11 and collect_flag = 1)   as  count7"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            NSString *count6 = [frs1 stringForColumn:@"count6"];
            NSString *count7 = [frs1 stringForColumn:@"count7"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5,count6,count7]];
        }
        return arr;
    }
}

//我的错题章节列表
-(NSMutableArray *)selectMyWrongChapter:(SubjectType)type{
    if(type == 1){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=1 and wrong_flag = 1)   as count0, \
                         (select count(*) from question_library where detail_type=1 and wrong_flag = 1)    as count1, \
                         (select count(*) from question_library where detail_type=2 and wrong_flag = 1)    as count2, \
                         (select count(*) from question_library where detail_type=3 and wrong_flag = 1)    as count3, \
                         (select count(*) from question_library where detail_type=4 and wrong_flag = 1)    as count4"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4]];
        }
        return arr;
        
    }
    else if(type == 3 || type == 4 || type == 5){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where (subject_type=1 or subject_type=%d) and wrong_flag = 1)  as count0, \
                         (select count(*) from question_library where detail_type=1 and wrong_flag = 1)                        as count1, \
                         (select count(*) from question_library where detail_type=2 and wrong_flag = 1)                        as count2, \
                         (select count(*) from question_library where detail_type=3 and wrong_flag = 1)                        as count3, \
                         (select count(*) from question_library where detail_type=4 and wrong_flag = 1)                        as count4, \
                         (select count(*) from question_library where subject_type=%d and wrong_flag = 1)                      as count5",type,type];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5]];
        }
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=2 and wrong_flag = 1)   as  count0, \
                         (select count(*) from question_library where detail_type=5 and wrong_flag = 1)    as  count1, \
                         (select count(*) from question_library where detail_type=6 and wrong_flag = 1)    as  count2, \
                         (select count(*) from question_library where detail_type=7 and wrong_flag = 1)    as  count3, \
                         (select count(*) from question_library where detail_type=8 and wrong_flag = 1)    as  count4, \
                         (select count(*) from question_library where detail_type=9 and wrong_flag = 1)    as  count5, \
                         (select count(*) from question_library where detail_type=10 and wrong_flag = 1)   as  count6, \
                         (select count(*) from question_library where detail_type=11 and wrong_flag = 1)   as  count7"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            NSString *count6 = [frs1 stringForColumn:@"count6"];
            NSString *count7 = [frs1 stringForColumn:@"count7"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5,count6,count7]];
        }
        return arr;
    }
}

//未做练习题章节列表
-(NSMutableArray *)selectNeverDoChapter:(SubjectType)type{
    if(type == 1){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=1 and do_num = 0)   as count0, \
                         (select count(*) from question_library where detail_type=1 and do_num = 0)    as count1, \
                         (select count(*) from question_library where detail_type=2 and do_num = 0)    as count2, \
                         (select count(*) from question_library where detail_type=3 and do_num = 0)    as count3, \
                         (select count(*) from question_library where detail_type=4 and do_num = 0)    as count4"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4]];
        }
        return arr;
        
    }
    else if(type == 3 || type == 4 || type == 5){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where (subject_type=1 or subject_type=%d) and do_num = 0)  as count0, \
                         (select count(*) from question_library where detail_type=1 and do_num = 0)                        as count1, \
                         (select count(*) from question_library where detail_type=2 and do_num = 0)                        as count2, \
                         (select count(*) from question_library where detail_type=3 and do_num = 0)                        as count3, \
                         (select count(*) from question_library where detail_type=4 and do_num = 0)                        as count4, \
                         (select count(*) from question_library where subject_type=%d and do_num = 0)                      as count5",type,type];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5]];
        }
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        /*
         1 道路交通安全法
         2 道路交通信号
         3 行车安全、文明驾驶
         4 机动车驾驶操作基础知识
         5 科目四违法的案例分析
         6 科目四安全行车常识
         7 科目四 常见交通标志、标线和交通手势辨识
         8 科目四驾驶职业道德和文明驾驶常识
         9 科目四恶劣天气和复杂道路条件下驾驶常识
         10 科目四紧急情况下避险常识
         11 科目四交通事故救护及常见危化品处置常识
         12 货车专用题
         13 客车专用
         14 摩托车专用
         */
        
        NSString *sql = [NSString stringWithFormat:@"select \
                         (select count(*) from question_library where subject_type=2 and do_num = 0)   as  count0, \
                         (select count(*) from question_library where detail_type=5 and do_num = 0)    as  count1, \
                         (select count(*) from question_library where detail_type=6 and do_num = 0)    as  count2, \
                         (select count(*) from question_library where detail_type=7 and do_num = 0)    as  count3, \
                         (select count(*) from question_library where detail_type=8 and do_num = 0)    as  count4, \
                         (select count(*) from question_library where detail_type=9 and do_num = 0)    as  count5, \
                         (select count(*) from question_library where detail_type=10 and do_num = 0)   as  count6, \
                         (select count(*) from question_library where detail_type=11 and do_num = 0)   as  count7"];
        
        
        
        FMResultSet *frs1 = [self executeQuery:sql];
        while(frs1.next)
        {
            NSString *count0 = [frs1 stringForColumn:@"count0"];
            NSString *count1 = [frs1 stringForColumn:@"count1"];
            NSString *count2 = [frs1 stringForColumn:@"count2"];
            NSString *count3 = [frs1 stringForColumn:@"count3"];
            NSString *count4 = [frs1 stringForColumn:@"count4"];
            NSString *count5 = [frs1 stringForColumn:@"count5"];
            NSString *count6 = [frs1 stringForColumn:@"count6"];
            NSString *count7 = [frs1 stringForColumn:@"count7"];
            [arr addObjectsFromArray:@[count0,count1,count2,count3,count4,count5,count6,count7]];
        }
        return arr;
    }
}

@end
