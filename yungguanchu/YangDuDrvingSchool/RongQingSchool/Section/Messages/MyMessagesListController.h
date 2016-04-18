//
//  MyMessagesListController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/7.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"
@interface MyMessagesListController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) UINib *cellNib;
@end
