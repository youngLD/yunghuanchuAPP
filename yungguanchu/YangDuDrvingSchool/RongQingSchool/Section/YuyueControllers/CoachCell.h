//
//  CoachCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoachCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *dayTimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour0TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour1TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour2TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour3TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour4TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour5TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour6TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour7TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *hour0MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour1MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour2MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour3MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour4MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour5MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour6MarkLb;

@property(strong,nonatomic) IBOutlet UILabel *hour7MarkLb;

@property(strong,nonatomic) IBOutlet UIButton *hour0TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour1TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour2TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour3TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour4TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour5TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour6TimeBtn;

@property(strong,nonatomic) IBOutlet UIButton *hour7TimeBtn;

@property(strong,nonatomic) IBOutlet UILabel *price0TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price1TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price2TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price3TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price4TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price5TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price6TimeLb;

@property(strong,nonatomic) IBOutlet UILabel *price7TimeLb;

@property(strong,nonatomic) NSArray *hourTimeAry;

@property(strong,nonatomic) NSArray *hourMarkAry;

@property(strong,nonatomic) NSArray *hourTimeBtnAry;

@property(strong,nonatomic) NSArray *priceAry;

@end
