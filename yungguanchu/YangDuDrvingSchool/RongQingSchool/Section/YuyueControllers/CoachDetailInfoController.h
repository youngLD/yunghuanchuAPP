//
//  CoachDetailInfoController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "TimerReservationItem.h"
#import "CoachDetailItem.h"
@interface CoachDetailInfoController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UIView *headerView;

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

//请求时间段
@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) TimerReservationItem *timerReservationItem;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UIImageView *headPic;

@property(strong,nonatomic) IBOutlet UILabel *nameLb;

@property(strong,nonatomic) IBOutlet UILabel *genderLb;

@property(strong,nonatomic) IBOutlet UILabel *jiaolingLb;

@property(strong,nonatomic) IBOutlet UILabel *moenyLb;

@property(strong,nonatomic) IBOutlet UILabel *callLb;

@property(strong,nonatomic) IBOutlet UILabel *groupLb;

//@property(weak,nonatomic) SoltlistItem *selectSoltListItem;
@property(strong,nonatomic) NSMutableArray *selectSoltListItems;

//可预约剩余次数
@property(nonatomic) int orderShengyuNum;

@property(strong,nonatomic) NSDictionary *dataDic;

@property(strong,nonatomic) IBOutlet UIView *starView;

@end
