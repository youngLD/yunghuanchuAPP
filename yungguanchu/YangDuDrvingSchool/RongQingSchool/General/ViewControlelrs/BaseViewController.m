//
//  BaseViewController.m
//  caipiao
//
//  Created by caitong on 14/12/1.
//  Copyright (c) 2014年 caitong. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bj01"] forBarMetrics:UIBarMetricsDefault];
    
    if(IS_IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bj01I7"] forBarMetrics:UIBarMetricsDefault];
    
    //    //设置导航条背景不透明
    //    self.navigationController.navigationBar.translucent = NO;
    
    //解决IOS7下，视图藏到导航条底下的问题
    if(IS_IOS7)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    /* 字体带阴影
     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor whiteColor],UITextAttributeTextColor,
     [UIFont boldSystemFontOfSize:20.0],UITextAttributeFont,
     [UIColor colorWithWhite:0.0 alpha:0.5],UITextAttributeTextShadowColor,
     [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],UITextAttributeTextShadowOffset,nil];
     */
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor whiteColor],UITextAttributeTextColor,
                         [UIFont systemFontOfSize:20.0],UITextAttributeFont,
                         [UIColor colorWithWhite:0.0 alpha:0.5],UITextAttributeTextShadowColor,
                         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = dic;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
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
