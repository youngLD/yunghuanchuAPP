//
//  UserInfo.h
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

typedef enum {
    XiaoChe = 1, //小车(C)
    KeMu2,  //科目2
    HuoChe, //货车(B) detail_type 12
    KeChe,  //客车(A) detail_type 13
    MoTuoChe,  //摩托车(其他) detail_type 14
} SubjectType;

/**
 *  记录当前用户在首页选择的科目：1科目一   2科目四
 */
@property(nonatomic) int KemuTag;

///**
// *  车类型：1小车 3货车 4客车 5摩托车
// */
//@property(nonatomic) int carType;

@property(nonatomic) SubjectType userCarType;

/**
 *  是否登录
 */
@property(nonatomic) BOOL isLogin;

/**
 *  头像
 */
@property(strong,nonatomic) NSString *appHeadPic;

/**
 *  学员用户名
 */
@property(strong,nonatomic) NSString *appUserName;

/**
 *  学员密码
 */
@property(strong,nonatomic) NSString *appUserPass;

/**
 *
 */
@property(strong,nonatomic) NSString *applyDate;

/**
 *  所学车型 A-客车 B-货车 C-小车 其他-摩托车
 */
@property(strong,nonatomic) NSString *cheXing;

/**
 *  当前状态
 */
@property(strong,nonatomic) NSString *currentState;

/**
 *  学车地点
 */
@property(strong,nonatomic) NSString *learnLocation;

/**
 *  手机号码
 */
@property(strong,nonatomic) NSString *mobile;

/**
 *  姓名
 */
@property(strong,nonatomic) NSString *name;

/**
 *  身份证号
 */
@property(strong,nonatomic) NSString *personIdentify;


/**
 *  学员状态 对应数字 1：待考科目1，2：科一模拟，3：科一考试，4：科二分车/培训，5：科二考试，6：科三分车/培训，7：科三考试，8：科四考试，9：结业
 */
@property(strong,nonatomic) NSString *stuStateNum;



/**
 *  用户id
 */
@property(strong,nonatomic) NSString *uId;

/**
 *  学习类型 计时班和普通班
 */
@property(strong,nonatomic) NSString *xxlx;

/**
 *  这个是预约里面 进去培训考试等预约的权限，K1ksyy值是 0 -1 1 ， 1可以进去  ， 0的时候 K1ksyyMsg 这个消息是说明原因
 */
@property(strong,nonatomic) NSDictionary *logUserSatate;

/**
 *  剩余钱数
 */
@property(strong,nonatomic) NSString *leftMoney;

@property(strong,nonatomic) NSString *msgCount;

+(UserInfo *)shareUserInfo;

-(void)setDataWithDic:(NSDictionary *)dic;

-(void)clearInfo;

@end
