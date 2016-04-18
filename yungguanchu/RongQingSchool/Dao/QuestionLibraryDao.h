//
//  QuestionLibraryDao.h
//  RongQingSchool
//
//  Created by zhangHui on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "BaseDao.h"
#import "QuestionLibraryItem.h"
#import "QuestionAnswerItem.h"

@interface QuestionLibraryDao : BaseDao

/**
 *  按科目查询
 *
 *  @param table 1科目一   2科目四
 *
 *  @return
 */
-(NSMutableArray *)selectQuestionLibrary:(NSString *)subject;

/**
 *  根据问题找对应的答案列表
 *
 *  @param dic 问题
 *
 *  @return
 */
-(NSMutableArray *)selectAnswer:(QuestionLibraryItem *)item;

/**
 *  查找所有的答案
 *
 *  @param questionAry 问题id数组
 *
 *  @return
 */
-(NSMutableArray *)selectAnswer2:(NSArray *)questionAry;

/**
 *  记录回答过的问题
 *
 *  @param item
 */
-(void)recordAnswerdQuestion:(QuestionLibraryItem *)item;

/**
 *  收藏/移除 题目
 *
 *  @param item
 */
-(void)collectQuestion:(QuestionLibraryItem *)item;

/**
 *  查找全部某科目搜藏过的问题
 */
-(NSMutableArray *)selectCollectedQuestion;

/**
 *  根据detail_type查找收藏过的题目
 */
-(NSMutableArray *)selectCollectedQuestionByDetail_type:(NSString *)detail_type;

/**
 *  按小车 货车 客车 摩托车 科目2 选取试题
 *  @param type 
 *
 *  @return
 */
-(NSMutableArray *)selectpageByCarType:(SubjectType)type;

///查找我的所有错题
-(NSMutableArray *)selectWrongQuestion;

///根据detail_type查找我的错题
-(NSMutableArray *)selectWrongQuestionByDetail:(NSString *)detail_type;

/**
 *  科目的所有未做练习题
 *
 *  @param type subject_type
 *
 *  @return
 */
-(NSMutableArray *)selectNeverDoQuestion:(SubjectType)type;

/**
 *  根据detail_type查找我的未做题
 *
 *  @param detail_type 章节信息
 *
 *  @return
 */
-(NSMutableArray *)selectNeverDoQuestionByDetail:(NSString *)detail_type;

/*
 * 顺序练习｜｜ 无序练习 yes:有序 no:无序
 */
-(NSMutableArray *)selectAll:(int)type byOrder:(BOOL)order;

///统计
-(NSMutableArray *)statistics:(int)type;

//按章节查询，章节所有（所有detail_type一样的）
-(NSMutableArray *)selectKemuAndDetailType:(NSString *)detailType;

-(void)sdsd;

@end
