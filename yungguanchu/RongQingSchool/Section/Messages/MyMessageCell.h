//
//  MyMessageCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/7.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *titleLb;

@property(strong,nonatomic) IBOutlet UILabel *contentLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

@property(strong,nonatomic) IBOutlet UIImageView *headPic;

@property(strong,nonatomic) IBOutlet UIImageView *arrowPic;

@property(strong,nonatomic) IBOutlet UIView *contenBgView;

@end
