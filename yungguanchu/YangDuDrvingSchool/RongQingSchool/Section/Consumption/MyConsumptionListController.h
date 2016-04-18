//
//  MyConsumptionListController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "ChargeItem.h"

@interface MyConsumptionListController : UIViewController

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UILabel *leftMoneyLb;

@end
