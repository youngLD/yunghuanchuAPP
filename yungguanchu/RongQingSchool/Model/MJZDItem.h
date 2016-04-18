//
//  MJZDItem.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJZDItem : NSObject

@property(strong,nonatomic) NSString *abstr;
@property(strong,nonatomic) NSString *content;
@property(nonatomic) long createTime;
@property(nonatomic) long flag;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *uid;
@property(nonatomic) long updateTime;

@end
