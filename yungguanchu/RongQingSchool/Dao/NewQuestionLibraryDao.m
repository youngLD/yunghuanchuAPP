//
//  NewQuestionLibraryDao.m
//  HongShunSchool
//
//  Created by 杨乐栋 on 16/1/31.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "NewQuestionLibraryDao.h"
#import "QuestionItem.h"
#include "QuestionAnswerItem.h"
@implementation NewQuestionLibraryDao
- (QuestionItem *)makeQuestionItem:(FMResultSet *)frs
{
    QuestionItem *item = [[QuestionItem alloc] init];
    item.subType=2;
    item.subid=[frs intForColumn:@"subId"];
    item.questionStr=[frs stringForColumn:@"question"];
    item.answer=[frs stringForColumn:@"answer"];
     item.subType=[frs intForColumn:@"subType"];
    if(item.answer.length>1)
    {
         item.subType=3;
    }
    item.optAStr=[frs stringForColumn:@"optA"];
    item.optBStr=[frs stringForColumn:@"optB"];
    item.optCStr=[frs stringForColumn:@"optC"];
    item.optDStr=[frs stringForColumn:@"optD"];
    if ([item.optDStr length]<1) {
        item.subType=1;
    }
    item.image_path=[frs stringForColumn:@"image_path"];
    item.flash_path=[frs stringForColumn:@"flash_path"];
    item.sortId=[frs intForColumn:@"sortId"];
    item.subject_type=[frs intForColumn:@"subject_type"];
   
    item.collect_flag=[frs intForColumn:@"collect_flag"];
    item.selectedAnswer=@"";
    item.isSelected=NO;
    item.optionStatus=-1;
    return item;
}
//查询某个问题的答案
-(NSMutableArray *)selectAnswer:(QuestionItem *)item{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where subid = %d",item.subid];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionAnswerItem *item1 = [[QuestionAnswerItem alloc] init];
        item1.id_ = [frs stringForColumn:@"subid"];
        item1.uid = @"A";
        item1.answer = [frs stringForColumn:@"optA"];
        item1.isSelected = NO;
        
        [ary addObject:item1];
        QuestionAnswerItem *item2 = [[QuestionAnswerItem alloc] init];
        item2.id_ = [frs stringForColumn:@"subid"];
        item2.uid = @"B";
        item2.answer = [frs stringForColumn:@"optB"];
        item2.isSelected = NO;
     
        [ary addObject:item2];
        if (item.subType==1) {
            return ary;
        }
       
        QuestionAnswerItem *item3 = [[QuestionAnswerItem alloc] init];
        item3.id_ = [frs stringForColumn:@"subid"];
        item3.uid = @"C";
        item3.answer = [frs stringForColumn:@"optC"];
        item3.isSelected = NO;
        
        [ary addObject:item3];
        QuestionAnswerItem *item4 = [[QuestionAnswerItem alloc] init];
        item4.id_ = [frs stringForColumn:@"subid"];
        item4.uid = @"D";
        item4.answer = [frs stringForColumn:@"optD"];
        item4.isSelected = NO;
        
        [ary addObject:item4];

    }
    
    return ary;
}
-(NSMutableArray *)selectQuestionLibrary:(NSString *)subject
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where subject_type = %d",subject.intValue];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionItem *item= [self makeQuestionItem:frs];
        [arr addObject:item];
    }
    
    return arr;
}
/**
 *  记录回答过的问题
 *
 *  @param item
 */
-(void)recordAnswerdQuestion:(QuestionItem *)item{
    
    int wrong_flag = 0;//默认值：还没有做过
    //错
    if(item.optionStatus == 0){
        wrong_flag = 1;
    }
    //对
    else if(item.optionStatus == 1){
        wrong_flag = 2;
    }
    NSString *sql = [NSString stringWithFormat:@"update question_library set do_num = 1,wrong_flag = %d where subId = %d",wrong_flag,item.subid];
    if(![self executeUpdate:sql]){
        CLog(@"错误了");
    }
}
/**
 *  收藏/移除 题目
 *
 *  @param item
 */
-(void)collectQuestion:(QuestionItem *)item{
    NSString *sql2 = [NSString stringWithFormat:@"update question_library set collect_flag = %d where subid = %d ",item.collect_flag,item.subid];
    
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
        QuestionItem *item = [self makeQuestionItem:frs];
        [arr addObject:item];
    }
    
    return arr;
}
/**
 *  根据sortId查找收藏过的题目
 */
-(NSMutableArray *)selectCollectedQuestionByDetail_type:(int)sortId{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    int kss=sortId;
    if (kss==5) {
        kss=301;
    }
    if (kss==6) {
        kss=302;
    }
    if (kss==7) {
        kss=303;
    }
    if (kss==8) {
        kss=304;
    }
    if (kss==9) {
        kss=305;
    }
    if (kss==10) {
        kss=306;
    }
    if (kss==11) {
        kss=307;
    }
    if (kss==12) {
        kss=6;
    }
    if (kss==13) {
        kss=5;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where collect_flag = 1 and sortId = %d",kss];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionItem *item = [self makeQuestionItem:frs];
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
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 1  order by random() limit 40"];
        
        //交通信号30
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 2 order by random() limit 30"];
        
        // 安全行车20
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 3 order by random() limit 20"];
        
        // 机动车驾驶操作相关基础知识10
        NSString *sql4 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 4 order by random() limit 10"];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs3];
            [arr addObject:item];
        }
        
        FMResultSet *frs4 = [self executeQuery:sql4];
        while(frs4.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs4];
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
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 1 order by random() limit 40"];
        
        //交通信号15
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 2 order by random() limit 15"];
        
        // 安全行车20
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 3 order by random() limit 20"];
        
        // 机动车驾驶操作相关基础知识10
        NSString *sql4 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and sortId = 4 order by random() limit 10"];
        //HuoChe, //货车(B) detail_type 12
        //KeChe,  //客车(A) detail_type 13
        //MoTuoChe,  //摩托车(其他) detail_type 14
        //相应专题15
        if (type==HuoChe) {
            type=6;
        }
        if (type==KeChe) {
            type=5;
        }
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where sortId = %d order by random() limit 15",type];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
           QuestionItem *item = [self makeQuestionItem:frs3];
            [arr addObject:item];
        }
        
        FMResultSet *frs4 = [self executeQuery:sql4];
        while(frs4.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs4];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
           QuestionItem *item = [self makeQuestionItem:frs5];
            [arr addObject:item];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //科目2里的判断题20
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and (subType=1) order by random() limit 20"];
        
        //单选25
        NSString *sql2 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and subType=2 order by random() limit 25"];
        
        // 多选5
        NSString *sql3 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 and subType=3 order by random() limit 5"];
        
        /*
         NSString *sql1 = [NSString stringWithFormat:@"(select * from question_library limit 3) union all (select * from question_library limit 3)"];
         */
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs2 = [self executeQuery:sql2];
        while(frs2.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs2];
            [arr addObject:item];
        }
        
        FMResultSet *frs3 = [self executeQuery:sql3];
        while(frs3.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs3];
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
        QuestionItem *item = [self makeQuestionItem: frs1];
        [ary addObject:item];
    }
    
    return ary;
}

///根据sortId查找我的错题
-(NSMutableArray *)selectWrongQuestionByDetail:(int)sortId{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    int kss=sortId;
    if (kss==5) {
        kss=301;
    }
    if (kss==6) {
        kss=302;
    }
    if (kss==7) {
        kss=303;
    }
    if (kss==8) {
        kss=304;
    }
    if (kss==9) {
        kss=305;
    }
    if (kss==10) {
        kss=306;
    }
    if (kss==11) {
        kss=307;
    }
    if (kss==12) {
        kss=6;
    }
    if (kss==13) {
        kss=5;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where wrong_flag = 1 and sortId = %d",kss];
    
    FMResultSet *frs1 = [self executeQuery:sql];
    while(frs1.next)
    {
        QuestionItem *item = [self makeQuestionItem: frs1];
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
            QuestionItem *item = [self makeQuestionItem:frs1];
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
        if (type==HuoChe) {
            type=6;
        }
        if (type==KeChe) {
            type=5;
        }
        
        //科目1
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 1 and do_num = 0"];
        
        //相应专题
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where sortId = %d and do_num = 0",type];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs5];
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
            QuestionItem *item = [self makeQuestionItem:frs1];
            [arr addObject:item];
        }
        
        return arr;
    }
}

/**
 *  根据detail_type查找我的未做题
 *
 *  @param detail_type 章节信息
 *
 *  @return
 */
-(NSMutableArray *)selectNeverDoQuestionByDetail:(NSString *)detail_type{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
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
    int kss=[detail_type intValue];
    if (kss==5) {
        kss=301;
    }
    if (kss==6) {
        kss=302;
    }
    if (kss==7) {
        kss=303;
    }
    if (kss==8) {
        kss=304;
    }
    if (kss==9) {
        kss=305;
    }
    if (kss==10) {
        kss=306;
    }
    if (kss==11) {
        kss=307;
    }
    if (kss==12) {
        kss=6;
    }
    if (kss==13) {
        kss=5;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where do_num =0 and sortId = %d",kss];
    
    FMResultSet *frs1 = [self executeQuery:sql];
    while(frs1.next)
    {
        QuestionItem *item = [self makeQuestionItem:frs1];
        [ary addObject:item];
    }
    
    return ary;
}

/*
 * 顺序练习｜｜ 无序练习 yes:有序 no:无序
 */
-(NSMutableArray *)selectAll:(int)type byOrder:(BOOL)order{
    
    NSString *orderSql = order? @"order by subid asc":@"order by random()";
    
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
            QuestionItem *item = [self makeQuestionItem:frs1];
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
        if (type==HuoChe) {
            type=6;
        }
        if (type==KeChe) {
            type=5;
        }
        //相应专题
        NSString *sql5 = [NSString stringWithFormat:@"select * from question_library where subject_type = %d %@",type,orderSql];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem: frs1];
            [arr addObject:item];
        }
        
        FMResultSet *frs5 = [self executeQuery:sql5];
        while(frs5.next)
        {
             QuestionItem *item = [self makeQuestionItem:frs5];
            [arr addObject:item];
        }
        
        return arr;
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
        
        //科目2
        NSString *sql1 = [NSString stringWithFormat:@"select * from question_library where subject_type = 2 %@",orderSql];
        
        FMResultSet *frs1 = [self executeQuery:sql1];
        while(frs1.next)
        {
            QuestionItem *item = [self makeQuestionItem:frs1];
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
    int kss=[detailType intValue];
    if (kss==5) {
        kss=301;
    }
    if (kss==6) {
        kss=302;
    }
    if (kss==7) {
        kss=303;
    }
    if (kss==8) {
        kss=304;
    }
    if (kss==9) {
        kss=305;
    }
    if (kss==10) {
        kss=306;
    }
    if (kss==11) {
        kss=307;
    }
    if (kss==12) {
        kss=6;
    }
    if (kss==13) {
        kss=5;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from question_library where sortId = %d",kss];
    
    FMResultSet *frs = [self executeQuery:sql];
    while(frs.next)
    {
        QuestionItem *item = [self makeQuestionItem: frs];
        [arr addObject:item];
    }
    
    return arr;
}

@end
