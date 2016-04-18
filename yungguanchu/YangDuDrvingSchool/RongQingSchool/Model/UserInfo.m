//
//  UserInfo.m
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(UserInfo *)shareUserInfo{
    static UserInfo *userInfo;
    if(!userInfo){
        userInfo = [[UserInfo alloc] init];
        NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:key_user_selected_car_type];
        if(!i) i = 0;
        userInfo.userCarType = (int)i;
        userInfo.KemuTag = 1;
        userInfo.uId = @"";
        return userInfo;
    }
    else{
        NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:key_user_selected_car_type];
        if(!i) i = 0;
        userInfo.userCarType = (int)i;
        return userInfo;
    }
}

-(void)setDataWithDic:(NSDictionary *)dic{
    self.appHeadPic = [Utils getValueFrom:dic byKey:@"AppHeadPic"];
    self.appUserName = [Utils getValueFrom:dic byKey:@"AppUserName"];
    self.appUserPass = [Utils getValueFrom:dic byKey:@"AppUserPass"];
    self.applyDate = [Utils getValueFrom:dic byKey:@"ApplyDate"];
    self.cheXing = [Utils getValueFrom:dic byKey:@"CheXing"];
    self.currentState = [Utils getValueFrom:dic byKey:@"CurrentState"];
    self.learnLocation = [Utils getValueFrom:dic byKey:@"LearnLocation"];
    self.mobile = [Utils getValueFrom:dic byKey:@"Mobile"];
    self.name = [Utils getValueFrom:dic byKey:@"Name"];
    self.personIdentify = [Utils getValueFrom:dic byKey:@"PersonIdentify"];
    self.stuStateNum = [Utils getValueFrom:dic byKey:@"StuStateNum"];
    self.uId = [Utils getValueFrom:dic byKey:@"UId"];
    self.xxlx = [Utils getValueFrom:dic byKey:@"Xxlx"];
    self.logUserSatate = [dic objectForKey:@"LogUserState"];
    self.leftMoney = [Utils getValueFrom:dic byKey:@"leftMoney"];
    self.msgCount = [Utils getValueFrom:dic byKey:@"msgCount"];
    
    if([self.cheXing hasPrefix:@"a"] || [self.cheXing hasPrefix:@"A"]){
        self.userCarType = KeChe;
    }
    else if([self.cheXing hasPrefix:@"b"] || [self.cheXing hasPrefix:@"B"]){
        self.userCarType = HuoChe;
    }
    else if([self.cheXing hasPrefix:@"c"] || [self.cheXing hasPrefix:@"C"]){
        self.userCarType = XiaoChe;
    }
    else{
        self.userCarType = MoTuoChe;
    }
}
-(void)clearInfo{
    self.appHeadPic = nil;
    self.appUserName = nil;
    self.appUserPass = nil;
    self.applyDate = nil;
    self.cheXing = nil;
    self.currentState = nil;
    self.learnLocation = nil;
    self.mobile = nil;
    self.name = nil;
    self.personIdentify = nil;
    self.stuStateNum = nil;
    self.uId = nil;
    self.xxlx = nil;
    self.logUserSatate = nil;
    self.leftMoney = @"0";
    self.msgCount = @"0";
    
    if([self.cheXing hasPrefix:@"a"] || [self.cheXing hasPrefix:@"A"]){
        self.userCarType = KeChe;
    }
    else if([self.cheXing hasPrefix:@"b"] || [self.cheXing hasPrefix:@"B"]){
        self.userCarType = HuoChe;
    }
    else if([self.cheXing hasPrefix:@"c"] || [self.cheXing hasPrefix:@"C"]){
        self.userCarType = XiaoChe;
    }
    else{
        self.userCarType = MoTuoChe;
    }
    self.isLogin = NO;
    [WQUserDataManager deletePassWord];
}

@end
