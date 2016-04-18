//
//  FirstChangePasswordController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/14.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "FirstChangePasswordController.h"

@interface FirstChangePasswordController ()

@end

@implementation FirstChangePasswordController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    /*
    if(!self.hideBackBtn){
        self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    }
    else{
        self.navigationItem.leftBarButtonItems = [self getLeftButtons];
    }
     */
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtonsTarget:self selector:@selector(pop)];
    self.navigationItem.rightBarButtonItems = [self getRightButtons];
    [self initView];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
}

-(void)requestData{

    [self.verifyCodeTf resignFirstResponder];
    [self.newpasswordTf resignFirstResponder];
    [self.verifyPasswordTf resignFirstResponder];
    if(![self.verifyCode isEqualToString:self.verifyCodeTf.text]){
        [Utils showMessage:@"verifyCodeWrong"];
        return;
    }
    if(![self.newpasswordTf.text isEqualToString:self.verifyPasswordTf.text]){
        [Utils showMessage:@"newpasswordNotSame"];
        return;
    }
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               [WQUserDataManager readPassWord],@"olp",
                               self.newpasswordTf.text,@"nwp", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_CUPw WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [WQUserDataManager savePassWord:self.newpasswordTf.text];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"passwordChangeSuccess"];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(IBAction)sendVerifyCode:(UIButton *)sender{
    if(![Utils isNullOrEmpty:[UserInfo shareUserInfo].mobile] && [UserInfo shareUserInfo].mobile.length == 11){
        if(self.verifyCodeRequest)[self.verifyCodeRequest.webRequest clearDelegatesAndCancel];
        self.verifyCodeRequest = [[GeneralWebRequest alloc] init];
        
        [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
        [self.verifyCodeRequest requestPhoneVerifyCodePhone:[UserInfo shareUserInfo].mobile successBlock:^(NSDictionary *resultDic) {
            [Utils showMessage:@"verifyCodeSendSuccess"];
            self.cutDownTime = 60;
            [self timeCountDown];
            [Utils removeProgressHUB:self.view];
            
            //验证码，本地验证
            self.verifyCode = [resultDic objectForKey:@"VerifyCode"];
            
        } failedBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
        }];
    }
    else{
        [Utils showMessage:@"手机号有问题"];
    }
}

-(void)timeCountDown{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)time:(NSTimer *)timer_{
    if(self.cutDownTime > 0){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cutDownTime --;
            [self.sendBtn setTitle:NSStringFromInt(self.cutDownTime) forState:UIControlStateNormal];
            self.sendBtn.userInteractionEnabled = NO;
        });
        
        
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cutDownTime = 60;
            [self.sendBtn setTitle:@"获取" forState:UIControlStateNormal];
            self.sendBtn.userInteractionEnabled = YES;
            
            [self.timer invalidate];
        });
        
        
    }
    
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

-(NSArray*)getLeftButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
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

-(void)pop{
    [[UserInfo shareUserInfo] clearInfo];
    [self.navigationController popViewControllerAnimated:YES];
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
