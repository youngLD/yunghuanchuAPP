//
//  AnswerCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *answerLb;

@property(strong,nonatomic) IBOutlet UIView *selectBgView1;

@property(strong,nonatomic) IBOutlet UILabel *abcdLb;
@property(strong,nonatomic) IBOutlet UIImageView *headPic;
@property(strong,nonatomic) IBOutlet UIView *abcdBgView;

@property(strong,nonatomic) IBOutlet UIButton *bgBtn;

@end
