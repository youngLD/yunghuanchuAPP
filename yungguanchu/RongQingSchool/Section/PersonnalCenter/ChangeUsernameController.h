//
//  ChangeUsernameController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface ChangeUsernameController : UIViewController

@property(strong,nonatomic) IBOutlet UITextField *userNameTf;

@property(strong,nonatomic) WebRequest *request;

@end
