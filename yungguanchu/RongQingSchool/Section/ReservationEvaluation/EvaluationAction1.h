//
//  EvaluationAction3.h
//  RongQingSchool
//
//  Created by Hui on 15/10/25.
//  Copyright © 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Evaluation5ClickIndexBlock)(NSInteger index);
@interface EvaluationAction1 : UIView

@property(strong,nonatomic) IBOutlet UIView *apgradeBgView;

@property(strong,nonatomic) IBOutlet UIView *starBgView0;

@property(strong,nonatomic) IBOutlet UIView *starBgView1;

@property(strong,nonatomic) IBOutlet UIView *starBgView2;

@property(strong,nonatomic) IBOutlet UIView *starBgView3;

@property(strong,nonatomic) IBOutlet UIView *starBgView4;

@property(strong,nonatomic) IBOutlet UIButton *leftBtn;

@property(strong,nonatomic) IBOutlet UIButton *rightBtn;

@property(strong,nonatomic) IBOutlet UIImageView *horPic;

@property(strong,nonatomic) IBOutlet UIImageView *verPic;

@property(strong,nonatomic) IBOutlet UIView *headerBgView;

@property(strong,nonatomic) Evaluation5ClickIndexBlock clickBlock;
@property(nonatomic) int star0;
@property(nonatomic) int star1;
@property(nonatomic) int star2;
@property(nonatomic) int star3;
@property(nonatomic) int star4;

@property(strong,nonatomic) NSString *apgString;

-(void)addClickBlock:(Evaluation5ClickIndexBlock)block;

-(void)defaultSetting;

@end
