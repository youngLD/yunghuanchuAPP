//
//  KaoshiYuyueListController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "ExamReservationItem.h"

@interface ExamReservationController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(weak,nonatomic) ExamReservationItem *selectedExamReservationItem;

@end
