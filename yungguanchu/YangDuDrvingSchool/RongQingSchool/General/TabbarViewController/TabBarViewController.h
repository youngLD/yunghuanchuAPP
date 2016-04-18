//
//  TabBarViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "TGViewController.h"
#import "LoginView.h"
#import "GeneralWebRequest.h"
#import "SettingCarType.h"
@interface TabBarViewController : UITabBarController

@property(strong,nonatomic) UIView *tabbarBgView;

@property(strong,nonatomic) TabBarView *tabbarView1;

@property(strong,nonatomic) TabBarView *tabbarView2;

@property(strong,nonatomic) TabBarView *tabbarView3;

@property(weak,nonatomic) TGViewController *leftMenuController;

@property(strong,nonatomic) UIButton *grayBtn;

@property(strong,nonatomic) LoginView *loginView;

@property(strong,nonatomic) GeneralWebRequest *versionRequest;

@property(strong,nonatomic) SettingCarType *settingCartypeView;

-(void)showCartypeSelect;

@end
