//
//  TablePickerView.h
//  RongQingSchool
//
//  Created by Hui on 15/9/3.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableClickAtIndexBlock)(NSInteger section, NSInteger row);

@interface TablePickerView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) UITableView *tableView;

@property(strong,nonatomic) NSArray *dataAry;

@property(strong,nonatomic) TableClickAtIndexBlock clickBlock;

-(void)reloadTableView;
-(void)addBloci:(TableClickAtIndexBlock)block;
@end
