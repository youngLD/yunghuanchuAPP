//
//  FirstChangePasswordController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/14.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
#import "GeneralWebRequest.h"
@interface FirstChangePasswordController : UIViewController
@property(strong,nonatomic) WebRequest *request;
@property(strong,nonatomic) IBOutlet UITextField *verifyCodeTf;
@property(strong,nonatomic) IBOutlet UITextField *newpasswordTf;
@property(strong,nonatomic) IBOutlet UITextField *verifyPasswordTf;

//倒计时
@property(nonatomic) int cutDownTime;

//dao ji shi
@property(strong,nonatomic) NSTimer *timer;

@property(strong,nonatomic) IBOutlet UIButton *sendBtn;

//验证码请求
@property(strong,nonatomic) GeneralWebRequest *verifyCodeRequest;

//是否隐藏返回按钮
@property(nonatomic) BOOL hideBackBtn;

@property(strong,nonatomic) NSString *verifyCode;
@end
