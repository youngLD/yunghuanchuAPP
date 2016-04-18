//
//  WebMacro.h
//  House
//  网络请求常量
//  Created by SarnathAir on 14-3-31.
//  Copyright (c) 2014年 Bandao. All rights reserved.
//

#ifndef House_WebMacro_h
#define House_WebMacro_h

#define ERROR_INFO(ErrorDomain,ErrorCode,ErroeDescript) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:[NSDictionary dictionaryWithObject:ErroeDescript forKey:NSLocalizedDescriptionKey]];

#define ERROR_NOINFO(ErrorDomain,ErrorCode) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:nil];

#define ERROR_DICTINFO(ErrorDomain,ErrorCode,ErroeDictionary) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:ErroeDictionary];


//#define SERVER_IP  @"http://115.28.228.147:88/"//测试地址

#define SERVER_IP @"http://yangdu.yixueyijia.cn/"//正式地址
#define VIDEO_SERVER_IP @"http://115.28.228.147:8080"

//登录
#define Action_Login @"AppService/appLogin.ashx?"

//培训预约显示（可选择的教师列表）
#define Action_TrainingJlList @"AppService/TrainingJlList.ashx?"

//分车计划
#define Action_FenCheJH @"AppService/FenCheJH.ashx?"

//获取分车指定教练列表
#define Action_FenCheJL @"AppService/FenCheJL.ashx?"

//分车预约显示
#define Action_CarorTraining @"AppService/CarorTraining.ashx?"

//车型与学习类型
#define Action_DropDownGet @"AppService/DropDownGet.ashx?"

//获取短信验证码
#define Action_phoneVerify @"AppService/phoneVerify.ashx?"

//在线报名
#define Action_OnlineRegis @"AppService/OnlineRegis.ashx?"

//教练培训预约时间段显示
#define Action_SelTraining @"AppService/SelTraining.ashx?"

//提交培训预约
#define Action_AddTrainingbook @"AppService/addTrainingbook.ashx?"

//提交分车预约
#define Action_AddCarorTrainbook @"AppService/addCarorTrainbook.ashx?"

//分车预约new
#define Action_FenCheYY @"AppService/FenCheYY.ashx?"

//我的预约查询列表
#define Action_QueryOrder @"AppService/QueryOrder.ashx?"

//考试预约列表
#define Action_ExamBook @"AppService/ExamBook.ashx?"

//考试预约
#define Action_AddExam @"AppService/addExambook.ashx?"

//当前预约详情
#define Action_OrderDetail @"AppService/OrderDetail.ashx?"

//取消考试预约
#define Action_CancleExambook @"AppService/CancleExambook.ashx?"

//取消分车预约
#define Action_FenCheQX @"AppService/FenCheQX.ashx?"

//服务评价列表
#define Action_DispAppraise @"AppService/DispAppraise.ashx?"

//对服务评价
#define Action_AppraiseAdd @"AppService/appraiseAdd.ashx?"

//修改用户名
#define Action_CUnm @"AppService/CUnm.ashx?"

//修改密码
#define Action_CUPw @"AppService/CUPw.ashx?"

//修改头像
#define Action_HeadPic @"AppService/HeadPic.ashx?"

//投诉建议
#define Action_AppComplain @"AppService/appComplain.ashx?"

//模拟考试成绩录入
#define Action_Simulation @"AppService/Simulation.ashx?"

//我的消费
#define Action_StuCharge @"AppService/stuCharge.ashx?"

//驾校详情
#define Action_SchoolInf @"AppService/schoolInf.ashx"

//获取未读消息
#define Action_GetMsg @"AppService/GetMsg.ashx?"

//版本信息
#define Action_AppVersion @"AppService/AppleVersion.ashx"

//退费申请
#define Action_JsbTfSq @"AppService/JsbTfSq.ashx?"

//取消预约
#define Action_CanTraOrd @"AppService/CanTraOrd.ashx?"

//流程信息状态
#define Action_FlowInfo @"AppService/flowInfo.ashx?"

//介绍人
#define Action_JSR @"AppService/JSR.ashx?"

//学车地点
#define Action_GetXQ @"AppService/GetXQ.ashx?"

//视频列表
#define Action_VideoList @"/api/teachingvideo/list"

//视频详情
#define Action_VideoDetail @"/api/teachingvideo/detail"

//文章详情
#define Action_ArticleDetail @"/api/examarticle/detail"

//秘籍指导
#define Action_MJZDList @"/api/examarticle/mjzd"

//秘籍指导详情
#define Action_MJZDDetail @"/api/examarticle/mjzddetail"

#endif

