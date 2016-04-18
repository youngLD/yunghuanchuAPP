//
//  EntryViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "TablePickerView.h"
#import "GeneralWebRequest.h"

@interface EntryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) UINib *cellNib;
@property(strong,nonatomic) UINib *cellNib2;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UIView *tableFooterView;

/**
 *  准驾车型详细信息
 */
@property(strong,nonatomic) NSDictionary *carDetailDic;

/**
 *  准驾车型数组
 */
@property(strong,nonatomic) NSMutableArray *carTypeAry;

/**
 *  学习地点数组
 */
@property(strong,nonatomic) NSMutableArray *studyAddressAry;

/**
 *  选择中队数组
 */
@property(strong,nonatomic) NSMutableArray *selectGroupAry;

/**
 *  选择介绍人数组
 */
@property(strong,nonatomic) NSMutableArray *selectJSRAry;


/**
 *  学习类型
 */
@property(strong,nonatomic) NSMutableArray *studyTypeAry;

/**
 *  性别类型
 */
@property(strong,nonatomic) NSMutableArray *genderAry;

/**
 *  请求
 */
@property(strong,nonatomic) WebRequest *request;

//弹出菜单
@property(strong,nonatomic) TablePickerView *tablePicker;

//当前点击cell的row
@property(nonatomic) NSIndexPath *selectedIndexPath;

//倒计时
@property(nonatomic) int cutDownTime;

//dao ji shi
@property(strong,nonatomic) NSTimer *timer;

//验证码请求
@property(strong,nonatomic) GeneralWebRequest *verifyCodeRequest;

@property(strong,nonatomic) WebRequest *commitRequet;

@property(strong,nonatomic) NSString *verifyCode;

//介绍人信息
@property(strong,nonatomic) NSDictionary *jsrDic;


@end
