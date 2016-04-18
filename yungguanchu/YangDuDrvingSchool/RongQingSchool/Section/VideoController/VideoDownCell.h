//
//  VideoDownCell.h
//  RongQingSchool
//
//  Created by caitong on 15/9/23.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListViewController.h"

@interface VideoDownCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIImageView *videoPic;

@property(strong,nonatomic) IBOutlet UILabel *titleLb;

@property(strong,nonatomic) IBOutlet UIButton *actionBtn;

@property(strong,nonatomic) IBOutlet UILabel *progressLb;

@property(strong,nonatomic) IBOutlet UIImageView *imageProView;//自己做的进度条VIEW
@property(strong,nonatomic) IBOutlet UIImageView *imageProBgView;//自己做的进度条VIEW背景

@property(weak,nonatomic) VideoListViewController *delegate;
@end
