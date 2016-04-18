//
//  QuestionItem.h
//  HongShunSchool
//
//  Created by 杨乐栋 on 16/1/31.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionItem : NSObject
@property (nonatomic)int subid;
@property (nonatomic,strong)NSString *questionStr;
@property (nonatomic,strong)NSString *optAStr;
@property (nonatomic,strong)NSString *optBStr;
@property (nonatomic,strong)NSString *optCStr;
@property (nonatomic,strong)NSString *optDStr;
@property (nonatomic,strong)NSString *image_path;
@property (nonatomic,strong)NSString *flash_path;
/*科目一 1道路交通安全法律，法规和规章
2道路交通信号
 3安全行车，基础知识
 4机动车驾驶操作相关知识
 5货车
 6客车
 科目四
 301 违法行为综合案例分析
 302 安全行车常识
 303 常见交通标示，标线和交通手势辨识
 304 驾驶职业道德和文明驾驶常识
 305恶劣气候和复杂道路条件下驾驶常识
 306紧急情况下避险常识
 307交通事故救护及常见危险品处置常识
 */
@property (nonatomic)int sortId;
//1是科目一 2是科目四
@property (nonatomic)int subject_type;
//正确答案
@property (nonatomic,strong)NSString *answer;
//选择题类型 1是判断 2是单选 3是多选
@property(nonatomic) int subType;

@property (nonatomic)int collect_flag;
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
//-(id)initWith
@end
