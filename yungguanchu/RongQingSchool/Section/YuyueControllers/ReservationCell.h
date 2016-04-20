//
//  YuyueCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIButton *yuyueBtn;

@property(strong,nonatomic) IBOutlet UIView *centerBgView;

@property(strong,nonatomic) IBOutlet UILabel *nameLb;

@property(strong,nonatomic) IBOutlet UILabel *sexLb;

@property(strong,nonatomic) IBOutlet UILabel *groupLb;

@property(strong,nonatomic) IBOutlet UILabel *mobileLb;

@property(strong,nonatomic) IBOutlet UILabel *moneyLb;

@property(strong,nonatomic) IBOutlet UIImageView *headPic;

@property(strong,nonatomic) IBOutlet UIControl *callCtl;

@property(strong,nonatomic) IBOutlet UILabel *yearsLb;

@property(strong,nonatomic) IBOutlet UIView *starBgView;
@property (weak, nonatomic) IBOutlet UILabel *tranNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *hpNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *zpNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cpNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiaoxiaoLable;

@end
