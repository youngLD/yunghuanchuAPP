//
//  NormalReservationDetailController2.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "CurrentReservationItem.h"
#import "ActionView.h"

@interface NormalReservationDetailController : UIViewController

@property(strong,nonatomic) IBOutlet UILabel *titleLb0;
@property(strong,nonatomic) IBOutlet UILabel *titleLb1;
@property(strong,nonatomic) IBOutlet UILabel *titleLb2;
@property(strong,nonatomic) IBOutlet UILabel *titleLb3;
@property(strong,nonatomic) IBOutlet UILabel *titleLb4;
@property(strong,nonatomic) IBOutlet UILabel *titleLb5;

@property(strong,nonatomic) IBOutlet UILabel *contentLb0;
@property(strong,nonatomic) IBOutlet UILabel *contentLb1;
@property(strong,nonatomic) IBOutlet UILabel *contentLb2;
@property(strong,nonatomic) IBOutlet UILabel *contentLb3;
@property(strong,nonatomic) IBOutlet UILabel *contentLb4;
@property(strong,nonatomic) IBOutlet UILabel *contentLb5;

@property(strong,nonatomic) NSDictionary *dataDic;

@property(strong,nonatomic) CurrentReservationItem *currentReservationItem;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) WebRequest *returnRequest;

@property(strong,nonatomic) IBOutlet UIButton *returnBtn;

@property(strong,nonatomic) ActionView *actionView;



@end
