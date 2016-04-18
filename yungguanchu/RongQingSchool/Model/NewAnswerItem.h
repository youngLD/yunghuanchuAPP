//
//  NewAnswerItem.h
//  HongShunSchool
//
//  Created by 杨乐栋 on 16/2/14.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewAnswerItem : NSObject

@property(strong,nonatomic) NSString *id_;

@property(strong,nonatomic) NSString *uid;

@property(strong,nonatomic) NSString *answer;

@property(nonatomic) BOOL isSelected;//是否选择了

@property(nonatomic) BOOL isTheCurrect;//是否是正确答案
@end
