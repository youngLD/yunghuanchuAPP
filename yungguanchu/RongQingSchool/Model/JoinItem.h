//
//  JoinItem.h
//  RongQingSchool
//
//  Created by Hui on 15/9/3.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinItem : NSObject

@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *content1;
@property(strong,nonatomic) NSString *image;
@property(strong,nonatomic) NSString *placeHolder;
-(id)initWithTitle:(NSString *)title_ withContent:(NSString *)content_ withImage:(NSString *)image_ placeHolder:(NSString *)placeHolder_;

-(id)initWithTitle:(NSString *)title_ withContent:(NSString *)content_ withContent1:(NSString *)content1_ withImage:(NSString *)image_ placeHolder:(NSString *)placeHolder_;
@end
