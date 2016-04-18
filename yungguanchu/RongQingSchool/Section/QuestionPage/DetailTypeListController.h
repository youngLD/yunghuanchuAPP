//
//  DetailTypeListController.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTypeDao.h"

@interface DetailTypeListController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) UINib *nib;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) NSArray *titleAry;
@property(strong,nonatomic) NSArray *detailTypeAry;

/**
 *  2:我的收藏 3:我的错题 6:章节练习 7:未做题练习
 */
@property(nonatomic) NSInteger type;


@end
