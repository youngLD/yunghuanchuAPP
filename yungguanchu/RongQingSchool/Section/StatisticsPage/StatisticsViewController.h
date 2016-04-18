//
//  StatisticsViewController.h
//  RongQingSchool
//
//  Created by Hui on 15/8/30.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWRChartView.h"

@interface StatisticsViewController : UIViewController

@property(strong,nonatomic) IBOutlet UIScrollView *scrollView;

@property(strong, nonatomic) TWRChartView *chartView;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) IBOutlet UIView *indicatorView;

@property(strong,nonatomic) IBOutlet UILabel *weizuoLb;

@property(strong,nonatomic) IBOutlet UILabel *weizuoLb2;

@property(strong,nonatomic) IBOutlet UILabel *datuiLb;

@property(strong,nonatomic) IBOutlet UILabel *datuiLb2;

@property(strong,nonatomic) IBOutlet UILabel *dacuoLb;

@property(strong,nonatomic) IBOutlet UILabel *dacuoLb2;

@property(strong,nonatomic) IBOutlet UILabel *zhengquelvLb;

@property(strong,nonatomic) IBOutlet UILabel *zhengquelvLb2;

@property(strong,nonatomic) IBOutlet UIView *whiteBgView;

@end
