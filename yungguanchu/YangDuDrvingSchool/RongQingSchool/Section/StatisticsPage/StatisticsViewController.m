//
//  StatisticsViewController.m
//  RongQingSchool
//
//  Created by Hui on 15/8/30.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "StatisticsViewController.h"
#import "TWRCircularChart.h"
#import "QuestionLibraryDao.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"练习统计";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initData];
    [self initView];
    
    [self loadPieChart];
}

-(void)initData{
    QuestionLibraryDao *dao = [[QuestionLibraryDao alloc] init];
    [dao openDataBase];
    if([UserInfo shareUserInfo].KemuTag == 1){
        self.dataAry = [dao statistics:[UserInfo shareUserInfo].userCarType];
    }
    else{
        self.dataAry = [dao statistics:KeMu2];
    }
    [dao closeDataBase];
}

-(void)initView{
    self.title = @"练习统计";
    
    self.scrollView.backgroundColor = MAIN_VIEW_COLOR;
    
    CGRect r = self.indicatorView.frame;
    r.origin.x = (UISCREEN_SIZE.width-r.size.width)/2;
    self.indicatorView.frame = r;
    
    self.whiteBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.whiteBgView.layer.borderWidth = 0.5;
    
    // Chart View
    _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(UISCREEN_SIZE.width/2-200/2, 0, 200, 200)];
    _chartView.backgroundColor = [UIColor clearColor];
    
    // User interaction is disabled by default. You can enable it again if you want
    // _chartView.userInteractionEnabled = YES;
    
    // Load chart by using a ChartJS javascript file
    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    [_chartView setChartJsFilePath:jsFilePath];
    
    // Add the chart view to the controller's view
    [self.scrollView addSubview:_chartView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 21)];
    lable.font = [UIFont systemFontOfSize:15];
    lable.textColor = UIColorFromRGB(102, 102, 102);
    [self.scrollView addSubview:lable];
    lable.center = _chartView.center;
    lable.textAlignment = NSTextAlignmentCenter;
    
    @try {
        CGFloat f = [self.dataAry[0] floatValue]/([self.dataAry[0] intValue]+[self.dataAry[1] intValue]+[self.dataAry[2] intValue])*100;
        lable.text = [NSString stringWithFormat:@"未做题比例%.2f%%",f];
        
        self.weizuoLb.text = [NSString stringWithFormat:@"%@",self.dataAry[0]];
        self.weizuoLb2.text = [NSString stringWithFormat:@"%.2f%%",[self.dataAry[0] floatValue]/([self.dataAry[0] floatValue]+[self.dataAry[1] floatValue]+[self.dataAry[2] floatValue])*100];
        
        self.datuiLb.text = [NSString stringWithFormat:@"%@",self.dataAry[1]];
        self.datuiLb2.text = [NSString stringWithFormat:@"%.2f%%",[self.dataAry[1] floatValue]/([self.dataAry[0] floatValue]+[self.dataAry[1] floatValue]+[self.dataAry[2] floatValue])*100];
        
        self.dacuoLb.text = [NSString stringWithFormat:@"%@",self.dataAry[2]];
        self.dacuoLb2.text = [NSString stringWithFormat:@"%.2f%%",[self.dataAry[2] floatValue]/([self.dataAry[0] floatValue]+[self.dataAry[1] floatValue]+[self.dataAry[2] floatValue])*100];
        
        self.zhengquelvLb.text = [NSString stringWithFormat:@"%@/%d",self.dataAry[1],[self.dataAry[1] intValue]+[self.dataAry[2] intValue]];
        if(([self.dataAry[1] floatValue]+[self.dataAry[2] floatValue]) == 0){
            self.zhengquelvLb2.text = [NSString stringWithFormat:@"%.2f%%",0.0];
        }
        else{
            self.zhengquelvLb2.text = [NSString stringWithFormat:@"%.2f%%",[self.dataAry[1] floatValue]/([self.dataAry[1] floatValue]+[self.dataAry[2] floatValue])*100];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

/**
 *  Loads a pie / doughnut chart using native code
 */
- (void)loadPieChart {
    // Values
    NSArray *values = self.dataAry;
    
    // Colors
    UIColor *color1 = UIColorFromRGB(232, 232, 232);
    UIColor *color2 = UIColorFromRGB(21, 167, 247);
    UIColor *color3 = UIColorFromRGB(234, 68, 74);
    NSArray *colors = @[color1, color2, color3];
    
    // Doughnut Chart
    TWRCircularChart *pieChart = [[TWRCircularChart alloc] initWithValues:values
                                                                   colors:colors
                                                                     type:TWRCircularChartTypeDoughnut
                                                                 animated:NO];
    //    pieChart.type = 0;
    
    // You can even leverage callbacks when chart animation ends!
    [_chartView loadCircularChart:pieChart withCompletionHandler:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
