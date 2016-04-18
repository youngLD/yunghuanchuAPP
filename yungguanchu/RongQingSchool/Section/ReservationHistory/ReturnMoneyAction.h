//
//  ReturnMoneyAction.h
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnMoneyAction : UIView<UITextViewDelegate>

typedef void(^ReturnMoneyClickIndexBlock)(NSInteger index);

@property(strong,nonatomic) IBOutlet UIView *headerBgView;

@property(strong,nonatomic) IBOutlet UITextView *inputTv;

@property(strong,nonatomic) IBOutlet UIButton *okBtn;

@property(strong,nonatomic) IBOutlet UIButton *cancleBtn;

@property(strong,nonatomic) IBOutlet UIImageView *line1;

@property(strong,nonatomic) IBOutlet UIImageView *line2;

@property(strong,nonatomic) IBOutlet UIImageView *line3;

@property(strong,nonatomic) IBOutlet UILabel *titleLb;

@property(strong,nonatomic) ReturnMoneyClickIndexBlock clickBlock;

@property(strong,nonatomic) IBOutlet UIView *inputAccessView;

@property(strong,nonatomic) IBOutlet UILabel *placeholderLb;

@property(strong,nonatomic) NSString *placeholderText;

-(void)addClickBlock:(ReturnMoneyClickIndexBlock)block;

@end
