//
//  TGViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"

@class TabBarViewController;

@interface TGViewController : UIViewController<UIGestureRecognizerDelegate>

@property(strong,nonatomic) TabBarViewController *mainViewController;

@property(strong,nonatomic) UIButton *shadowBtn;

@property(strong,nonatomic) IBOutlet UIView *contentView;

@property(strong,nonatomic) LoginView *loginView;

@property(strong,nonatomic) IBOutlet UIButton *headerPicBtn;

@property(strong,nonatomic) IBOutlet UILabel *nameLb;

@property(strong,nonatomic) IBOutlet UILabel *currentStateLb;

@property(strong,nonatomic) NSArray *controllers;

@property(strong,nonatomic) IBOutlet UIButton *loginBtn;

@property(strong,nonatomic) IBOutlet UIButton *cartypeBtn;

/**
 *  0:个人资料 1:我的消费 2:我的预约 3:投诉建议
 */
@property(nonatomic) NSInteger loginFlag;

-(void)showLeftMenu;

@end
