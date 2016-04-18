//
//  YunGuanHomePageViewController.m
//  zhihuaSchool
//
//  Created by 杨乐栋 on 16/4/18.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "YunGuanHomePageViewController.h"
#import "GeneralWebRequest.h"
#import "TabBarViewController.h"
#import "EntryViewController.h"
@interface YunGuanHomePageViewController ()
@property (nonatomic,strong) GeneralWebRequest *generalWR;
@end

@implementation YunGuanHomePageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self getDataList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    [self getDataList];
//    self.navigationItem.rightBarButtonItems = [self getNewRightButtons];
    // Do any additional setup after loading the view.
}
-(void)getDataList
{
    if (self.generalWR) {
        [self.generalWR.webRequest clearDelegatesAndCancel];

    }
    self.generalWR=[GeneralWebRequest new];
    [self.generalWR GetHomePageInfoSuccessBlock:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    } failedBlock:^(NSDictionary *resultDic) {
        
    }];
    
}
-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"left_menu_bar"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //    [backbtn setTitle:@"♬" forState:UIControlStateNormal];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

-(IBAction)showLeftMenu:(id)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.leftMenuController showLeftMenu];
    
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
