//
//  ChangeUsernameController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ChangeUsernameController.h"

@interface ChangeUsernameController ()

@end

@implementation ChangeUsernameController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户名设置";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.navigationItem.rightBarButtonItems = [self getRightButtons];
    
    [self initView];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
}

-(void)requestData{
    [self.userNameTf resignFirstResponder];
    if([Utils isNullOrEmpty:self.userNameTf.text] || self.userNameTf.text.length<3){
        [Utils showMessage:@"userNameFormatWrong"];
        return;
    }
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               self.userNameTf.text,@"unm", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_CUnm WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"userNameChangeSuccess"];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSArray*)getRightButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitle:@"保存" forState:UIControlStateNormal];
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
