//
//  NormalReservationListController0.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "CoachSelectAction.h"
#import "NormalReservationItem0.h"

@interface NormalReservationListController0 : UIViewController

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) WebRequest *reservationRequest;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) CoachSelectAction *coachSelectAction;

@property(weak,nonatomic) NormalReservationItem0 *selectedNormalReservationItem0;

@end
