//
//  TimerYuyueListController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface TimerReservationListController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

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

@property(strong,nonatomic) IBOutlet UIView *indicatorView;

@property(strong,nonatomic) IBOutlet UIControl *grayBgControl;

@property(nonatomic) BOOL menu1IsShow;

@property(nonatomic) BOOL menu2IsShow;

@property(strong,nonatomic) IBOutlet WebRequest *request;
@property(strong,nonatomic) WebRequest *requestSchool;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top1;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top2;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *height2;

@property(strong,nonatomic) IBOutlet UIButton *dateBtn1;
@property(strong,nonatomic) IBOutlet UIButton *dateBtn2;
@property(strong,nonatomic) IBOutlet UIButton *dateBtn3;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn4;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn5;

//时间数组
@property(strong,nonatomic) NSMutableArray *timeAry;

//教练
@property(strong,nonatomic) NSMutableArray *coachAry;

//弹出的教练姓名列表
@property(strong,nonatomic) IBOutlet UITableView *coachTableview;

@property(strong,nonatomic) UINib *nib2;

//选择的日期
@property(strong,nonatomic) NSString *selectedDate;

//选择的教练
@property(strong,nonatomic) NSString *selectedCoachID;

//查询关键字
@property(strong,nonatomic) NSString *searchStr;

@property(strong,nonatomic) IBOutlet UIView *titleView;

@property(strong,nonatomic) IBOutlet UITextField *searchTf;

@property(strong,nonatomic) UIButton *rightItemBtn;

@property(nonatomic) BOOL isTitleViewShow;

@property(strong,nonatomic) IBOutlet NSLayoutConstraint *leading;

//是否复训  1 是复训 0 非复训
@property(strong,nonatomic) NSString *sffx;

@property(strong,nonatomic) IBOutlet UIButton *coachBtn0;
@property(strong,nonatomic) IBOutlet UIButton *coachBtn1;

@end
