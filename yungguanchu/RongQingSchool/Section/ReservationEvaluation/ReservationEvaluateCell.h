//
//  ReservationEvaluateCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationEvaluateCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIButton *evaluationBtn;

@property(strong,nonatomic) IBOutlet UILabel *typeLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

@property(strong,nonatomic) IBOutlet UILabel *evaluationDesLb;

@property(strong,nonatomic) IBOutlet UIView *allStarBgView;

@property(strong,nonatomic) IBOutlet UIView *starView;
@property(strong,nonatomic) IBOutlet UIView *starView1;
@property(strong,nonatomic) IBOutlet UIView *starView2;
@property(strong,nonatomic) IBOutlet UIView *starView3;
@property(strong,nonatomic) IBOutlet UIView *starView4;

@property(strong,nonatomic) IBOutlet UILabel *stateLb;

@property(strong,nonatomic) IBOutlet UIView *evaluationBgView;

@property(strong,nonatomic) IBOutlet UILabel *starTitleLb;

@property(strong,nonatomic) IBOutlet UIView *contentBgView;

@end
