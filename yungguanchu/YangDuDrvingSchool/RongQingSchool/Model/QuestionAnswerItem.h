//
//  QuestionAnswerItem.h
//  RongQingSchool
//
//  Created by caitong on 15/8/21.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionAnswerItem : NSObject

@property(strong,nonatomic) NSString *id_;

@property(strong,nonatomic) NSString *uid;

@property(strong,nonatomic) NSString *answer;

@property(nonatomic) BOOL isSelected;//是否选择了

@property(nonatomic) BOOL isTheCurrect;//是否是正确答案

@end
