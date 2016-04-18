//
//  NormalReservationCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalReservationCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIButton *btn;

@property(strong,nonatomic) IBOutlet UILabel *carTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *subjectTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

@property(strong,nonatomic) IBOutlet UILabel *totalNumLb;

@property(strong,nonatomic) IBOutlet UILabel *leftNumLb;

@end
