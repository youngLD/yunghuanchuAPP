//
//  MySuggestionController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface MySuggestionController : UIViewController<UITextViewDelegate>

@property(strong,nonatomic) IBOutlet UITextField *textField;

@property(strong,nonatomic) IBOutlet UITextView *inputTv;

@property(strong,nonatomic) IBOutlet UILabel *placeholderLb;

@property(strong,nonatomic) WebRequest *request;

@end
