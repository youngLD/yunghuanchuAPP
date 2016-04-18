//
//  PayForTimerYuyueController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "CoachDetailItem.h"
#import "ActionView.h"
@interface PayForTimerReservationController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

//请求参数
@property(strong,nonatomic) NSDictionary *postParam;

//选择的时间段
@property(strong,nonatomic) NSArray *selectSoltListItems;

//提交预约
@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) IBOutlet UIView *moneyBgView;

@property(strong,nonatomic) IBOutlet UIView *tableBgView;

@property(strong,nonatomic) IBOutlet UIButton *okBtn;

@property(strong,nonatomic) NSString *coachName;

@property(strong,nonatomic) IBOutlet UILabel *coachNameLb;
@property(strong,nonatomic) IBOutlet UILabel *moneyLb;

@property(strong,nonatomic) NSString *totalMoney;

@property(strong,nonatomic) ActionView *actionView;

@property(strong,nonatomic) ActionView *actionView2;

@end
