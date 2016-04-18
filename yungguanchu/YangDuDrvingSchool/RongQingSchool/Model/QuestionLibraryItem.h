//
//  QuestionLibraryItem.h
//  RongQingSchool
//
//  Created by caitong on 15/8/21.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionLibraryItem : NSObject

/**
 *  问题id
 */
@property(strong,nonatomic) NSString *uid;

/**
 *  image path
 */
@property(strong,nonatomic) NSString *image_path;

/**
 *  gif path
 */
@property(strong,nonatomic) NSString *flash_path;

/**
 *  答案id
 */
@property(strong,nonatomic) NSString *answerId;

/**
 *  正确答案
 */
@property(strong,nonatomic) NSString *answer;

/**
 *  科目：1科目一   2科目四 3货车 4客车 5摩托车
 */
@property(nonatomic) int subject_type;

/**
 *  做题次数
 */
@property(strong,nonatomic) NSString *do_num;

/**
 *  章节信息 
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
@property(strong,nonatomic) NSString *detail_type;

/**
 *  0单选 1多选 2判断
 */
@property(nonatomic) int option_type;

/**
 *  主键
 */
@property(strong,nonatomic) NSString *id_;

/**
 *  默认0未收藏 1收藏
 */
@property(nonatomic) int collect_flag;

/**
 *  问题内容
 */
@property(strong,nonatomic) NSString *question;

/**
 *  是否选择完成
 */
@property(nonatomic) BOOL isSelected;

/**
 *  用户选择的答案
 */
@property(strong,nonatomic) NSString *selectedAnswer;

/**
 *  是否答对, -1:未选择 1:对 0:错
 */
@property(nonatomic) NSInteger optionStatus;

@end
