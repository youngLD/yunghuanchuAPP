//
//  ExamRecordCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamRecordCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *indexLb;

@property(strong,nonatomic) IBOutlet UILabel *scoreLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

@property(strong,nonatomic) IBOutlet UILabel *dateLb;

@property(strong,nonatomic) IBOutlet UIImageView *resultPic;

@property(strong,nonatomic) IBOutlet UIImageView *headPic;
@end
