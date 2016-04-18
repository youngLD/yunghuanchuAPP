//
//  ExamRecordListController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamRecordListController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) IBOutlet UINib *nib;

@property(strong,nonatomic) NSMutableArray *dataAry;

@end
