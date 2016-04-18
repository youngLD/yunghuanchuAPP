//
//  SettingViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    self.view.backgroundColor = MAIN_VIEW_COLOR;
}

-(IBAction)versionCheck:(id)sender{
    if(self.versionRequest) [self.versionRequest.webRequest clearDelegatesAndCancel];
    self.versionRequest = [[GeneralWebRequest alloc] init];
    
    [self.versionRequest requestVersionInfoSuccessBlock:^(NSDictionary *resultDic) {
        CLog(@"%@",resultDic);
        BOOL haveNewVersion = [resultDic[@"flag"] boolValue];
        if(!haveNewVersion){
            [Utils showMessage:@"当前已经是最新版本了"];
        }
    } failedBlock:^(NSDictionary *resultDic) {
        
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
