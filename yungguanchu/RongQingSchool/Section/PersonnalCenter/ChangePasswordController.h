//
//  ChangePasswordController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface ChangePasswordController : UIViewController
@property(strong,nonatomic) WebRequest *request;
@property(strong,nonatomic) IBOutlet UITextField *oldPasswordTf;
@property(strong,nonatomic) IBOutlet UITextField *newpasswordTf;
@property(strong,nonatomic) IBOutlet UITextField *verifyPasswordTf;
@end
