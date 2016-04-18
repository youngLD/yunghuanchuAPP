//
//  NormalYuyueListController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "NormalReservationItem.h"

@interface NormalReservationListController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) IBOutlet UIButton *btn1;

@property(strong,nonatomic) IBOutlet UILabel *titleLb1;

@property(strong,nonatomic) IBOutlet UIImageView *titlePic1;

@property(strong,nonatomic) IBOutlet UIButton *btn2;

@property(strong,nonatomic) IBOutlet UILabel *titleLb2;

@property(strong,nonatomic) IBOutlet UIImageView *titlePic2;

@property(strong,nonatomic) IBOutlet UIView *menuBgView1;

@property(strong,nonatomic) IBOutlet UIView *menuBgView2;

@property(nonatomic) BOOL menu1IsShow;

@property(nonatomic) BOOL menu2IsShow;

@property(strong,nonatomic) IBOutlet UIView *indicatorView;

@property(strong,nonatomic) IBOutlet UIControl *grayBgControl;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(weak,nonatomic) NormalReservationItem *selectedNoramlReservationItem;

@property(strong,nonatomic) NSString *xid;
@property(strong,nonatomic) NSString *strsearch;

@end
