//
//  SettingCarType.h
//  RongQingSchool
//
//  Created by caitong on 15/9/9.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickIndexBlock1)(NSInteger index);
@interface SettingCarType : UIView

@property(strong,nonatomic) NSArray *controls;

@property(strong,nonatomic) IBOutlet UIControl *ctrl0;
@property(strong,nonatomic) IBOutlet UIControl *ctrl1;
@property(strong,nonatomic) IBOutlet UIControl *ctrl2;
@property(strong,nonatomic) IBOutlet UIControl *ctrl3;
@property(strong,nonatomic) ClickIndexBlock1 clickBlock;

@property(nonatomic) NSInteger selectedIndex;

-(void)addClickBlock:(ClickIndexBlock1)block;

-(void)defaultSetting;


@end
