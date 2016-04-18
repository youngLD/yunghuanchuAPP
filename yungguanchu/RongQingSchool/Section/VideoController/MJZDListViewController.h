//
//  MJZDListViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoWebRequest.h"

@interface MJZDListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) VideoWebRequest *request;

@property(strong,nonatomic) IBOutlet UINib *nib;
@end
