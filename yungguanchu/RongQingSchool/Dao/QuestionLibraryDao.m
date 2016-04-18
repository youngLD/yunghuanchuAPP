//
//  QuestionLibraryDao.m
//  RongQingSchool
//
//  Created by zhangHui on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "QuestionLibraryDao.h"
#import "QuestionLibraryItem.h"

@implementation QuestionLibraryDao

/**
 *  按科目查询
 *
 *  @param table 1科目一   2科目四
 *
 *  @return
 */
-(NSMutableArray *)selectQuestionLibrary:(NSString *)subject
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where subject_type = %d",subject.intValue];

    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs];
        
        [arr addObject:item];
    }

    return arr;
}

/**
 *  根据问题找对应的答案列表
 *
 *  @param dic 问题
 *
 *  @return
 */
-(NSMutableArray *)selectAnswer:(QuestionLibraryItem *)item{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql = [NSString stringWithFormat:@"select * from question_answer_map where questionId = '%@'",item.uid];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionAnswerItem *item = [[QuestionAnswerItem alloc] init];
        item.id_ = [frs stringForColumn:@"id"];
        item.uid = [frs stringForColumn:@"uid"];
        item.answer = [frs stringForColumn:@"answer"];
        item.isSelected = NO;
        
        [ary addObject:item];
    }
    
    return ary;
}

/**
 *  查找所有的答案
 *
 *  @param questionAry 问题id数组
 *
 *  @return
 */
-(NSMutableArray *)selectAnswer2:(NSArray *)questionAry{
    
    NSMutableArray *ary1 = [NSMutableArray arrayWithCapacity:20];
    for(NSDictionary *dic in questionAry){
        NSString *sql = [NSString stringWithFormat:@"select * from question_answer_map where questionId = '%@'",[dic objectForKey:@"uid"]];
        
        //一组答案
        NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
        FMResultSet *frs = [self executeQuery:sql];
        while(frs.next)
        {
            QuestionAnswerItem *item = [[QuestionAnswerItem alloc] init];
            item.id_ = [frs stringForColumn:@"id"];
            item.uid = [frs stringForColumn:@"uid"];
            item.answer = [frs stringForColumn:@"answer"];
            item.isSelected = NO;
            
            [ary addObject:item];
        }
        
        [ary1 addObject:ary];
    }
    
    
    return ary1;
}

/**
 *  记录回答过的问题
 *
 *  @param item
 */
-(void)recordAnswerdQuestion:(QuestionLibraryItem *)item{
    
    int wrong_flag = 0;//默认值：还没有做过
    //错
    if(item.optionStatus == 0){
        wrong_flag = 1;
    }
    //对
    else if(item.optionStatus == 1){
        wrong_flag = 2;
    }
    NSString *sql = [NSString stringWithFormat:@"update question_library set do_num = 1,wrong_flag = %d where uid = '%@'",wrong_flag,item.uid];
    if(![self executeUpdate:sql]){
        CLog(@"错误了");
    }
}

-(void)sdsd{
    NSString *sql = [NSString stringWithFormat:@"select * from question_library"];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionLibraryItem *item = [[QuestionLibraryItem alloc] init];
        item.uid = [frs stringForColumn:@"uid"];
        NSString *s = [item.uid substringWithRange:NSMakeRange(1,item.uid.length-2)];
        
        NSString *sql2 = [NSString stringWithFormat:@"update question_library set uid = '%@' where uid = '%@'",s,item.uid];
        
        if(![self executeUpdate:sql2]){
            CLog(@"错误了");
        }
        
    }
    
}

/**
 *  收藏/移除 题目
 *
 *  @param item
 */
-(void)collectQuestion:(QuestionLibraryItem *)item{
    NSString *sql2 = [NSString stringWithFormat:@"update question_library set collect_flag = %d where uid = '%@'",item.collect_flag,item.uid];
    
    if(![self executeUpdate:sql2]){
        CLog(@"错误了");
    }
}

/**
 *  查找全部某科目搜藏过的问题
 */
-(NSMutableArray *)selectCollectedQuestion{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql;
    if([UserInfo shareUserInfo].KemuTag == 1)
        sql = [NSString stringWithFormat:@"select * from question_library where collect_flag = 1 and subject_type != 2"];
    else
        sql = [NSString stringWithFormat:@"select * from question_library where collect_flag = 1 and subject_type = 2"];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs];
        [arr addObject:item];
    }
    
    return arr;
}

/**
 *  根据detail_type查找收藏过的题目
 */
-(NSMutableArray *)selectCollectedQuestionByDetail_type:(NSString *)detail_type{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where collect_flag = 1 and detail_type = %@",detail_type];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs];
        [arr addObject:item];
    }
    
    return arr;
}

/**
 *  按小车 货车 客车 摩托车 科目2 选取试题
 *  @param type 
 *
 *  @return
 */
-(NSMutableArray *)selectpageByCarType:(SubjectType)type{
    
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
        
        //科目1里的道路交通安全法40
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 1 order by random() limit 40"];
        
        //交通信号30
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 2 order by random() limit 30"];
        
        // 安全行车20
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 3 order by random() limit 20"];
        
        // 机动车驾驶操作相关基础知识10
        NSString *sql4 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 4 order by random() limit 10"];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs3];
            [arr addObject:item];
        }
        
        FMResultSet *frs4 = [self executeQuery:sql4];
        while(frs4.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs4];
            [arr addObject:item];
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
        
        //科目1里的道路交通安全法40
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 1 order by random() limit 40"];
        
        //交通信号15
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 2 order by random() limit 15"];
        
        // 安全行车20
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 3 order by random() limit 20"];
        
        // 机动车驾驶操作相关基础知识10
        NSString *sql4 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and detail_type = 4 order by random() limit 10"];
        
        //相应专题15
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where subject_type = %d order by random() limit 15",type];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs3];
            [arr addObject:item];
        }
        
        FMResultSet *frs4 = [self executeQuery:sql4];
        while(frs4.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs4];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs5];
            [arr addObject:item];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //科目2里的判断题20
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and (answerid = 0 or answerid = 1) order by random() limit 20"];
        
        //单选25
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and option_type = 0 and answerId != 0 and answerId != 1 order by random() limit 25"];
        
        // 多选5
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and option_type = 1 order by random() limit 5"];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs3];
            [arr addObject:item];
        }
        
        return arr;
    }
}

///查找我的所有错题
-(NSMutableArray *)selectWrongQuestion{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql;
    if([UserInfo shareUserInfo].KemuTag == 1)
        sql = [NSString stringWithFormat:@"select * from question_library where subject_type != 2 and wrong_flag = 1"];
    else
        sql = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and wrong_flag = 1"];
    
    FMResultSet *frs1 = [self executeQuery:sql];
    while(frs1.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs1];
        [ary addObject:item];
    }
    
    return ary;
}

///根据detail_type查找我的错题
-(NSMutableArray *)selectWrongQuestionByDetail:(NSString *)detail_type{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where wrong_flag = 1 and detail_type = %@",detail_type];
    
    FMResultSet *frs1 = [self executeQuery:sql];
    while(frs1.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs1];
        [ary addObject:item];
    }
    
    return ary;
}

/**
 *  科目的所有未做练习题
 *
 *  @param type subject_type
 *
 *  @return
 */
-(NSMutableArray *)selectNeverDoQuestion:(SubjectType)type{
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
        
        //科目1
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and do_num = 0"];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
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
        
        //科目1
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and do_num = 0"];
        
        //相应专题
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where subject_type = %d and do_num = 0",type];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs5];
            [arr addObject:item];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //科目2
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and do_num = 0"];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        return arr;
    }
}

/**
 *  根据detail_type查找我的错题
 *
 *  @param detail_type 章节信息
 *
 *  @return
 */
-(NSMutableArray *)selectNeverDoQuestionByDetail:(NSString *)detail_type{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where do_num =0 and detail_type = %@",detail_type];
    
    FMResultSet *frs1 = [self executeQuery:sql];
    while(frs1.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs1];
        [ary addObject:item];
    }
    
    return ary;
}

/*
 * 顺序练习｜｜ 无序练习 yes:有序 no:无序
 */
-(NSMutableArray *)selectAll:(int)type byOrder:(BOOL)order{
    
    NSString *orderSql = order? @"order by id asc":@"order by random()";
    
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
        
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 %@",orderSql];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
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
        
        //科目1
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 %@",orderSql];
        
        //相应专题
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where subject_type = %d %@",type,orderSql];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs5];
            [arr addObject:item];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //科目
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 %@",orderSql];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionLibraryItem *item = [self dealWithFRS:frs1];
            [arr addObject:item];
        }
        
        return arr;
    }
}

///统计
-(NSMutableArray *)statistics:(int)type{
    
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
        
        //未做的
        NSString *sql1 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 1 and wrong_flag = 0"];
        
        //答对的
        NSString *sql2 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 1 and wrong_flag = 2"];
        
        //答错的
        NSString *sql3 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 1 and wrong_flag = 1"];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs1 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs2 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs3 intForColumnIndex:0]];
            [arr addObject:a];
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
        
        //未做的
        NSString *sql1 = [NSString stringWithFormat:@"select count(*) from question_library where (subject_type = 1 or subject_type = %d) and wrong_flag = 0",type];
        
        //答对的
        NSString *sql2 = [NSString stringWithFormat:@"select count(*) from question_library where (subject_type = 1 or subject_type = %d) and wrong_flag = 2",type];
        
        //答错的
        NSString *sql3 = [NSString stringWithFormat:@"select count(*) from question_library where (subject_type = 1  or subject_type = %d) and wrong_flag = 1",type];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs1 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs2 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs3 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //未做的
        NSString *sql1 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 2 and wrong_flag = 0"];
        
        //答对的
        NSString *sql2 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 2 and wrong_flag = 2"];
        
        //答错的
        NSString *sql3 = [NSString stringWithFormat:@"select count(*) from question_library where subject_type = 2 and wrong_flag = 1"];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs1 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs2 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            NSNumber *a = [NSNumber numberWithInt:[frs3 intForColumnIndex:0]];
            [arr addObject:a];
        }
        
        return arr;
        
        return arr;
    }
}

//按章节查询，章节所有（所有detail_type一样的）
-(NSMutableArray *)selectKemuAndDetailType:(NSString *)detailType{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where detail_type = %@",detailType];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionLibraryItem *item = [self dealWithFRS:frs];
        [arr addObject:item];
    }
    
    return arr;
}




-(QuestionLibraryItem *)dealWithFRS:(FMResultSet *)frs{
    QuestionLibraryItem *item = [[QuestionLibraryItem alloc] init];
    item.uid = [frs stringForColumn:@"uid"];
    
    item.image_path = [frs stringForColumn:@"image_path"];
    item.flash_path = [frs stringForColumn:@"flash_path"];
    item.answerId = [frs stringForColumn:@"answerId"];
    item.answer = [frs stringForColumn:@"answer"];
    item.subject_type = [frs intForColumn:@"subject_type"];
    item.detail_type = [frs stringForColumn:@"detail_type"];
    int ot = [frs intForColumn:@"option_type"];
    
    //多选
    if(ot == 1){
        item.option_type = 1;
    }
    else{
        //判断题
        if([@"0" isEqualToString:item.answerId] || [@"1" isEqualToString:item.answerId]){
            item.option_type = 2;
        }
        //单选
        else{
            item.option_type = 0;
        }
    }
    item.id_ = [frs stringForColumn:@"id"];
    item.collect_flag = [frs intForColumn:@"collect_flag"];
    item.question = [NSString stringWithFormat:@"%@",[frs stringForColumn:@"question"]];
    item.isSelected = NO;
    item.optionStatus = -1;
    
    return item;
}
@end
