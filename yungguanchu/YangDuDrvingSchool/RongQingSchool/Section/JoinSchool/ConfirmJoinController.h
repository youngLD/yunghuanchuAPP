//
//  ConfirmJoinController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/8.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionView.h"
#import "WebRequest.h"

@interface ConfirmJoinController : UIViewController

@property(strong,nonatomic) IBOutlet UILabel *moneyLb;

@property(strong,nonatomic) ActionView *actionView;

@property(strong,nonatomic) ActionView *actionView2;

@property(strong,nonatomic) WebRequest *commitRequet;

@property(strong,nonatomic) NSArray *images;

@property(strong,nonatomic) NSDictionary *postParam;

@property(strong,nonatomic) NSString *totalMoney;

@end
