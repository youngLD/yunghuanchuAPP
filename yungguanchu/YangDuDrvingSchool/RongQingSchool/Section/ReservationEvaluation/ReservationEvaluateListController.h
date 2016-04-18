//
//  ReservationEvaluateController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluationAction5.h"
#import "EvaluationAction3.h"
#import "EvaluationAction1.h"
#import "WebRequest.h"
#import "ReservationEvaluateItem.h"

@interface ReservationEvaluateListController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) EvaluationAction1 *evaluationActionView1;
@property(strong,nonatomic) EvaluationAction3 *evaluationActionView3;
@property(strong,nonatomic) EvaluationAction5 *evaluationActionView5;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) ReservationEvaluateItem *selectedReservationEvaluationItem;
@end
