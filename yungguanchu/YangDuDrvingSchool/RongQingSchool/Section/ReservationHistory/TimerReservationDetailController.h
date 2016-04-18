//
//  NormalReservationDetailController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnMoneyAction.h"
#import "ActionView.h"
#import "CurrentReservationItem.h"
#import "WebRequest.h"
#import "PxSoltListItem.h"

@interface TimerReservationDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UIView *tableBgview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) UINib *nib0;
@property(strong,nonatomic) UINib *nib1;
@property(strong,nonatomic) NSDictionary *pxOrderDetailDic;

@property(strong,nonatomic) IBOutlet UILabel *timeTitleLb;

@property(strong,nonatomic) IBOutlet UIImageView *timeTitleVerticalPic;

@property(strong,nonatomic) IBOutlet UIImageView *bottomLine;

@property(strong,nonatomic) IBOutlet UIScrollView *bgScrollView;

@property(strong,nonatomic) ReturnMoneyAction *returnActionView;
@property(strong,nonatomic) ActionView *actionView;

@property(strong,nonatomic) CurrentReservationItem *currentReservationItem;
@property(weak,nonatomic) PxSoltListItem *currentPxSoltListItem;

@property(strong,nonatomic) WebRequest *request;
@property(strong,nonatomic) WebRequest *returnRequest;

@property(strong,nonatomic) IBOutlet UILabel *typeLb;
@property(strong,nonatomic) IBOutlet UILabel *timeLb;
@property(strong,nonatomic) IBOutlet UILabel *stateLb;
@property(strong,nonatomic) IBOutlet UILabel *coachLb;
@property(strong,nonatomic) IBOutlet UILabel *genderLb;
@property(strong,nonatomic) IBOutlet UILabel *groupLb;
@property(strong,nonatomic) IBOutlet UILabel *jiaolingLb;

@property(strong,nonatomic) NSMutableArray *dataAry;

@end
