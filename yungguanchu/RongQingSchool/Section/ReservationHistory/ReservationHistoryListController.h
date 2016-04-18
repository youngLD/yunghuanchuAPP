//
//  ReservationHistoryListController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnMoneyAction.h"
#import "EvaluationAction1.h"
#import "WebRequest.h"
#import "CurrentReservationItem.h"
#import "EndReservationItem.h"
#import "ActionView.h"

@interface ReservationHistoryListController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib0;
@property(strong,nonatomic) IBOutlet UINib *nib1;
@property(strong,nonatomic) IBOutlet UINib *nib2;

@property(strong,nonatomic) IBOutlet ReturnMoneyAction *returnMoneyActionView;

@property(strong,nonatomic) EvaluationAction1 *evaluationActionView;
@property(strong,nonatomic) ActionView *actionView;

@property(strong,nonatomic) WebRequest *request;
@property(strong,nonatomic) WebRequest *returnRequest;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(weak,nonatomic) CurrentReservationItem *selectedCurrentReservationItem;
@property(weak,nonatomic) EndReservationItem *selectedEndReservationItem;
@end
