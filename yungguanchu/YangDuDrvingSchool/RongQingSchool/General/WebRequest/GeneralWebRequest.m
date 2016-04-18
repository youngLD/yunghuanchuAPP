//
//  GeneralWebRequest.m
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "GeneralWebRequest.h"
#import "MJExtension.h"
#import "UIAlertView+XY.h"

@implementation GeneralWebRequest

/**
 *  登录
 *
 *  @param userName 用户名
 *  @param pwd      密码
 *  @param code     验证码
 */
-(void)requestLogin:(NSString *)userName passWord:(NSString *)pwd successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock{
    self.webRequest = [[WebRequest alloc] init];
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName",pwd,@"userPassword", nil];
    [self.webRequest requestGetWithAction:Action_Login WithParameter:postDic successBlock:^(NSDictionary *resultDic) {
        [[UserInfo shareUserInfo] setDataWithDic:[resultDic objectForKey:@"Result"]];
        [UserInfo shareUserInfo].isLogin = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Login_Success object:nil];
        
        //保存信息
        [WQUserDataManager savePassWord:pwd];
        [[NSUserDefaults standardUserDefaults] setObject:[[resultDic objectForKey:@"Result"] objectForKey:@"PersonIdentify"] forKey:@"PersonIdentify"];
        [[NSUserDefaults standardUserDefaults] setObject:[[resultDic objectForKey:@"Result"] objectForKey:@"AppUserName"] forKey:@"AppUserName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        successBlock(resultDic);
        
    } failedBlock:^(NSDictionary *resultDic) {
        failedBlock(resultDic);
    }];
}

/**
 *  发送验证码
 *
 *  @param number 手机号
 */
-(void)requestPhoneVerifyCodePhone:(NSString *)number successBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock{
    self.webRequest = [[WebRequest alloc] init];
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"",@"stuId",
                             number,@"sjh", nil];
    
    [self.webRequest requestGetWithAction:Action_phoneVerify WithParameter:postDic successBlock:^(NSDictionary *resultDic) {
        successBlock(resultDic);
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Login_Success object:nil];
        
    } failedBlock:^(NSDictionary *resultDic) {
        failedBlock(resultDic);
    }];
}

/**
 *  请求版本信息
 *
 *  @param successBlock =
 *  @param failedBlock
 */
-(void)requestVersionInfoSuccessBlock:(SuccessResponeBlock)successBlock failedBlock:(FailedResponeBlock)failedBlock{
    self.webRequest = [[WebRequest alloc] init];
    
    [self.webRequest requestGetWithAction:Action_AppVersion WithParameter:nil successBlock:^(NSDictionary *resultDic) {
        
        NSArray *newary = [[[resultDic objectForKey:@"appVersion"] objectForKey:@"versionNo"] componentsSeparatedByString:@"."];
        NSArray *oldary = [APP_VERSION componentsSeparatedByString:@"."];
        
        BOOL haveNewVersion = NO;
        for(int i=0; i<newary.count; i++){
            if(oldary.count > i){
                NSString *newversion = newary[i];
                NSString *oldversion = oldary[i];
                
                if(newversion.intValue > oldversion.intValue){
                    haveNewVersion = YES;
                    break;
                }
                else if(newversion.intValue < oldversion.intValue){
                    break;
                }
            }
            if(oldary.count <= i){
                NSString *newversion = newary[i];
                if(![newversion isEqualToString:@"0"]){
                    haveNewVersion = YES;
                    break;
                }
                
            }
        }
        
        if(haveNewVersion){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测到新版本" message:[resultDic objectForKey:@"Msg"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
            [alert show];
            [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
                if(btnIndex == 1){
                    NSURL *url = [NSURL URLWithString:[[resultDic objectForKey:@"appVersion"] objectForKey:@"downloadPath"]];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
        else{
            NSDictionary *dic = @{@"flag":[NSNumber numberWithBool:haveNewVersion]};
            successBlock(dic);
        }
        
    } failedBlock:^(NSDictionary *resultDic) {
        failedBlock(resultDic);
    }];
}

@end
