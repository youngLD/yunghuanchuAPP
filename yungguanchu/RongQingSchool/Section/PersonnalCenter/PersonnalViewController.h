//
//  PersonnalViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface PersonnalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UIScrollView *bgScrollView;

/**
 *  头像
 */
@property(strong,nonatomic) IBOutlet UIButton *headPicBtn;


@property(strong,nonatomic) IBOutlet UILabel *nameLb;

@property(strong,nonatomic) IBOutlet UILabel *aplyLb;

@property(strong,nonatomic) IBOutlet UILabel *userNameLb;

@property(strong,nonatomic) IBOutlet UILabel *carTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *studyTypeLb;

@property(strong,nonatomic) IBOutlet UILabel *studyAddressLb;

@property(strong,nonatomic) IBOutlet UILabel *currentStateLb;

@property(strong,nonatomic) IBOutlet UILabel *mobileLb;

@property(strong,nonatomic) IBOutlet UILabel *idCardLb;

@property(strong,nonatomic) WebRequest *commitRequet;
@end
