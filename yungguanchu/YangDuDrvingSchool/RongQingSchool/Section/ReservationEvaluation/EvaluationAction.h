//
//  EvaluationAction.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EvaluationClickIndexBlock)(NSInteger index);
@interface EvaluationAction : UIView

@property(strong,nonatomic) IBOutlet UIButton *leftBtn;

@property(strong,nonatomic) IBOutlet UIButton *rightBtn;

@property(strong,nonatomic) IBOutlet UIImageView *horPic;

@property(strong,nonatomic) IBOutlet UIImageView *verPic;

@property(strong,nonatomic) IBOutlet UIView *starBgView;

@property(strong,nonatomic) IBOutlet UIView *headerBgView;

@property(strong,nonatomic) EvaluationClickIndexBlock clickBlock;

@property(nonatomic) int star;

-(void)addClickBlock:(EvaluationClickIndexBlock)block;

-(void)defaultSetting;

@end
