//
//  JoinSchoolController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/21.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WebRequest.h"
@interface SchoolDetailController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (strong, nonatomic) IBOutlet UIView *headerBgView;

@property (strong, nonatomic) IBOutlet UIView *jianjieBgView;

@property (strong, nonatomic) IBOutlet UIView *liuchengBgView;

@property (strong, nonatomic) IBOutlet UIView *bancheBgView;

@property (strong, nonatomic) IBOutlet UIButton *putongBanBtn;

@property (strong, nonatomic) IBOutlet UIButton *jishiBanBtn;

@property (strong, nonatomic) IBOutlet UILabel *banjiTypeLb;

@property (strong, nonatomic) IBOutlet UIImageView *banjiTypeImageView;

@property (strong, nonatomic) IBOutlet UIView *banjiTypeBgView;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) IBOutlet UITableView *wayTableView;

@property(strong,nonatomic) IBOutlet NSArray *wayAry;

@property(strong,nonatomic) UINib *cellNib;

/**
 *  学校名称
 */
@property(strong,nonatomic) IBOutlet UILabel *schoolNameLb;

/**
 *  学校地址
 */
@property(strong,nonatomic) IBOutlet UILabel *schoolAddressLb;

/**
 *  学校电话
 */
@property(strong,nonatomic) IBOutlet UILabel *schoolTelLb;

/**
 *  学校介绍
 */
@property(strong,nonatomic) IBOutlet UILabel *schoolDescLb;

/**
 *  数据
 */
@property(strong,nonatomic) NSDictionary *dataDic;

@property(strong,nonatomic) IBOutlet UIButton *expandBtn;
@end
