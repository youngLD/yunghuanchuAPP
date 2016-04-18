//
//  YuyueViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GeneralWebRequest.h"

@interface ReservationHomeController : BaseViewController

@property(strong,nonatomic) IBOutlet UIView *headerBgView;

@property(strong,nonatomic) IBOutlet UIView *footerBgView;

@property(strong,nonatomic) IBOutlet UIScrollView *bgScrollView;

@property(strong,nonatomic) IBOutlet UILabel *nameLb;

@property(strong,nonatomic) IBOutlet UILabel *carTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *studyTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *studyAddressLb;

@property(strong,nonatomic) IBOutlet UILabel *currentStateLb;

@property(strong,nonatomic) IBOutlet UILabel *stateDetailLb;

@property(strong,nonatomic) IBOutlet UIImageView *currentStatePic;

@property(strong,nonatomic) IBOutlet UIButton *menu0Btn;
@property(strong,nonatomic) IBOutlet UIButton *menu1Btn;
@property(strong,nonatomic) IBOutlet UIButton *menu2Btn;
@property(strong,nonatomic) IBOutlet UIButton *menu3Btn;
@property(strong,nonatomic) IBOutlet UIButton *menu4Btn;

@property(strong,nonatomic) IBOutlet UILabel *menu1Lb;

@property(strong,nonatomic) GeneralWebRequest *loginRequest;

@property(strong,nonatomic) IBOutlet UILabel *infoLb;
@property(strong,nonatomic) IBOutlet UIImageView *infoPic;
@end
