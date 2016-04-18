//
//  KaoshiYuyueCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamReservationCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIButton *btn;

@property(strong,nonatomic) IBOutlet UIView *contentView2;

@property(strong,nonatomic) IBOutlet UILabel *carTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *detailTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

@property(strong,nonatomic) IBOutlet UILabel *addressLb;

@property(strong,nonatomic) IBOutlet UILabel *totalNumLb;

@property(strong,nonatomic) IBOutlet UILabel *leftNumLb;
@end
