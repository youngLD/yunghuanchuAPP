//
//  LoginView.h
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property(strong,nonatomic) IBOutlet UITextField *userNameTf;

@property(strong,nonatomic) IBOutlet UITextField *passWordTf;

@property(strong,nonatomic) IBOutlet UITextField *vericodeTf;

@property(strong,nonatomic) IBOutlet UIButton *closeBtn;

@property(strong,nonatomic) IBOutlet UIButton *loginBtn;

-(void)clearInputInfo;

-(void)addHubProgressView;

-(void)removeHubProgressView;
@end
