//
//  EntryCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *titleLb;

@property(strong,nonatomic) IBOutlet UIImageView *topLine;

@property(strong,nonatomic) IBOutlet UIButton *contentBtn;

@property(strong,nonatomic) IBOutlet UITextField *contentTf;

@property(strong,nonatomic) IBOutlet UIButton *rightBtn;

@property(strong,nonatomic) IBOutlet UIButton *photoBtn;

@property(strong,nonatomic) IBOutlet UIButton *selectGroupBtn;

@property(strong,nonatomic) IBOutlet UIButton *selectZJRBtn;
@end
