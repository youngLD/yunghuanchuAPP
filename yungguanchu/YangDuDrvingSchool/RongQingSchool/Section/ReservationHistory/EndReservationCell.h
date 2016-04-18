//
//  EndReservationCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndReservationCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIButton *actionBtn;

@property(strong,nonatomic) IBOutlet UIButton *evaluationBtn;

@property(strong,nonatomic) IBOutlet UILabel *typeLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;


@property(strong,nonatomic) IBOutlet UILabel *statusLb;

@property(strong,nonatomic) IBOutlet UILabel *statusDescLb;

@property(strong,nonatomic) IBOutlet UILabel *jlxmLb;

@property(strong,nonatomic) IBOutlet UILabel *jldhLb;

@property(strong,nonatomic) IBOutlet UILabel *jlchLb;

@end
