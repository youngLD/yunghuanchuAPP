//
//  YuyueViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ReservationHomeController.h"
#import "NormalReservationListController0.h"
#import "ExamReservationController.h"
#import "QuestionListController.h"
#import "TimerReservationListController.h"
#import "ReservationEvaluateListController.h"
#import "ReservationHistoryListController.h"
#import "TabBarViewController.h"
#import "FlowInfoViewController.h"
extern BOOL isMainViewDisplaying;
@interface ReservationHomeController ()

@end

@implementation ReservationHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:Notification_Login_Success object:nil];
}

-(void)initView{
    [self loginSuccess];
    self.bgScrollView.frame = CGRectMake(0, 0, UISCREEN_SIZE.width, self.bgScrollView.frame.size.height);
    self.bgScrollView.backgroundColor = MAIN_VIEW_COLOR;
    
    CGRect rs = self.headerBgView.frame;
    rs.size.height *= WIDTH_SCALE;
    self.headerBgView.frame = rs;
    
    rs = CGRectMake(self.footerBgView.frame.origin.x,
                    self.footerBgView.frame.origin.y,
                    UISCREEN_SIZE.width,
                    self.footerBgView.frame.size.height);
    self.footerBgView.frame = rs;
    
    for(UIView *v in self.bgScrollView.subviews){
        CGRect r = v.frame;
        r.origin.y *= WIDTH_SCALE;
        v.frame = r;
    }
    
    
    
    for(UIView *v in self.headerBgView.subviews){
        CGRect r = v.frame;
        r.origin.x *= WIDTH_SCALE;
        r.origin.y *= WIDTH_SCALE;
        r.size.width *= WIDTH_SCALE;
        r.size.height *= WIDTH_SCALE;
        v.frame = r;
        for(UIView *vv in v.subviews){
            CGRect rr = vv.frame;
            rr.origin.x *= WIDTH_SCALE;
            rr.origin.y *= WIDTH_SCALE;
            rr.size.width *= WIDTH_SCALE;
            rr.size.height *= WIDTH_SCALE;
            vv.frame = rr;
            
        }
    }
    
    if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
        CGRect r = self.currentStatePic.frame;
        r.size.width *= WIDTH_SCALE;
        r.size.height *= WIDTH_SCALE;
        self.currentStatePic.frame = r;
    }
    
    CGRect r = self.footerBgView.frame;
    r.size.height = CGRectGetMaxY(self.currentStatePic.frame);
    self.footerBgView.frame = r;
    self.headerBgView.clipsToBounds = YES;
    if(IS_IPHONE_6 || IS_IPHONE_6_PLUS || IS_IPHONE_5){
        CGFloat f = UISCREEN_SIZE.height-KTOP_HEIGHT-49-CGRectGetMaxY(self.footerBgView.frame);
        CGFloat newf = f+self.headerBgView.frame.size.height;
        CGFloat scale = newf/self.headerBgView.frame.size.height;
        
        CGRect rr = self.headerBgView.frame;
        rr.size.height *= scale;
        self.headerBgView.frame = rr;
        
        for(UIView *v in self.headerBgView.subviews){
            v.center = CGPointMake(v.center.x, v.center.y*scale);
        }
        
        rr = self.infoLb.frame;
        rr.origin.y += f;
        self.infoLb.frame = rr;
        
        rr = self.infoPic.frame;
        rr.origin.y += f;
        self.infoPic.frame = rr;
        
        rr = self.footerBgView.frame;
        rr.origin.y += f;
        self.footerBgView.frame = rr;
        
    }
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerBgView.frame.size.height/2, UISCREEN_SIZE.width, 0.5)];
    v1.backgroundColor = UIColorFromRGB(220, 220, 220);
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(self.headerBgView.frame.size.width/3, 0, 0.5, self.headerBgView.frame.size.height)];
    v2.backgroundColor = UIColorFromRGB(220, 220, 220);
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(self.headerBgView.frame.size.width/3*2, 0, 0.5, self.headerBgView.frame.size.height)];
    v3.backgroundColor = UIColorFromRGB(220, 220, 220);
    
    [self.headerBgView addSubview:v1];
    [self.headerBgView addSubview:v2];
    [self.headerBgView addSubview:v3];
    
    self.headerBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.headerBgView.layer.borderWidth = 0.5;
    
    self.footerBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.footerBgView.layer.borderWidth = 0.5;
//    [Utils setBorderforView:self.footerBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoFlowInfo)];
    [self.currentStatePic addGestureRecognizer:tap];
    self.currentStatePic.userInteractionEnabled = YES;
    
    self.bgScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.footerBgView.frame));
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    isMainViewDisplaying = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
}

-(void)viewDidDisappear:(BOOL)animated{
    isMainViewDisplaying = NO;
    [super viewDidDisappear:animated];
}

-(void)loginSuccess{
    self.nameLb.text = [UserInfo shareUserInfo].name;
    self.carTypeLb.text = [UserInfo shareUserInfo].cheXing;
    self.studyTypeLb.text = [UserInfo shareUserInfo].xxlx;
    self.studyAddressLb.text = [UserInfo shareUserInfo].learnLocation;
    self.currentStateLb.text = [UserInfo shareUserInfo].currentState;
    self.stateDetailLb.adjustsFontSizeToFitWidth = YES;
    
    NSDictionary *logUserSatate = [UserInfo shareUserInfo].logUserSatate;
    if([(logUserSatate[@"k2pxxs"]) intValue] > 0 || [(logUserSatate[@"k2needxs"]) intValue] > 0){
        self.stateDetailLb.text = [NSString stringWithFormat:@"科目二已培训%@学时，仍需%@学时",logUserSatate[@"k2pxxs"],(logUserSatate[@"k2needxs"])];
    }
    else if([(logUserSatate[@"k3pxxs"]) intValue] > 0 || [(logUserSatate[@"k3needxs"]) intValue] > 0){
        self.stateDetailLb.text = [NSString stringWithFormat:@"科目三已培训%@学时，仍需%@学时",logUserSatate[@"k3pxxs"],logUserSatate[@"k3needxs"]];
    }
    else{
        self.stateDetailLb.text = @"";
    }
    
    if ([[UserInfo shareUserInfo].xxlx isEqualToString:@"普通班"]) {
        self.menu1Lb.text = @"分车预约";
        
        self.currentStatePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"liucheng_%@_fenche",[UserInfo shareUserInfo].stuStateNum]];
    }
    else{
        self.menu1Lb.text = @"培训预约";
        
        self.currentStatePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"liucheng_%@_peixun",[UserInfo shareUserInfo].stuStateNum]];
    }
}

//考前模拟
-(IBAction)kaoqianMoniClick:(id)sender{
    [self refreshAuth:^(BOOL finished) {
        if([@1 isEqualToNumber:[[UserInfo shareUserInfo].logUserSatate objectForKey:@"Mnks"]]){
            QuestionListController *questionListController = [[QuestionListController alloc] init];
            questionListController.type = 8;
            questionListController.title = @"模拟考试";
            [self.navigationController pushViewController:questionListController animated:YES];
        }
        else{
            [Utils showMessage:@"veservationNoPermssion"];
        }
    }];
}

//分车预约、培训预约
-(IBAction)fenchepeinxunYuyue:(id)sender{
//    NormalReservationListController0 *normalYuyueListController = [[NormalReservationListController0 alloc] init];
//    [self.navigationController pushViewController:normalYuyueListController animated:YES];
//    return;
    [self refreshAuth:^(BOOL finished) {
        if([@"普通班" isEqualToString:[UserInfo shareUserInfo].xxlx]){
            BOOL havePemission = NO;
            //封装请求表单
            NSString *key = nil;
            NSEnumerator *myEnumerator3=[[UserInfo shareUserInfo].logUserSatate keyEnumerator];
            while (key=[myEnumerator3 nextObject])
            {
                if([key rangeOfString:@"fcyy"].length == 4){
                    NSString *value = [NSString stringWithFormat:@"%@",[[UserInfo shareUserInfo].logUserSatate objectForKey:key]];
                    if([@"1" isEqualToString:value]){
                        havePemission = YES;
                        break;
                    }
                    
                }
            }
            
            if(havePemission){
                NormalReservationListController0 *normalYuyueListController = [[NormalReservationListController0 alloc] init];
                [self.navigationController pushViewController:normalYuyueListController animated:YES];
            }
            else{
                [Utils showMessage:@"veservationNoPermssion"];
            }
            
        }
        else{
            BOOL havePemission = NO;
            //封装请求表单
            NSString *key = nil;
            NSEnumerator *myEnumerator3=[[UserInfo shareUserInfo].logUserSatate keyEnumerator];
            while (key=[myEnumerator3 nextObject])
            {
                if([key rangeOfString:@"pxyy"].length == 4){
                    NSString *value = [NSString stringWithFormat:@"%@",[[UserInfo shareUserInfo].logUserSatate objectForKey:key]];
                    if([@"1" isEqualToString:value]){
                        havePemission = YES;
                        break;
                    }
                    
                }
            }
            
            if(havePemission){
                TimerReservationListController *timerReservationListController = [[TimerReservationListController alloc] init];
                [self.navigationController pushViewController:timerReservationListController animated:YES];
            }
            else{
                [Utils showMessage:@"veservationNoPermssion"];
            }
        }
    }];
    
}

//考试预约
-(IBAction)kaoshiYuyue:(id)sender{
    [self refreshAuth:^(BOOL finished) {
        BOOL havePemission = NO;
        //封装请求表单
        NSString *key = nil;
        NSEnumerator *myEnumerator3=[[UserInfo shareUserInfo].logUserSatate keyEnumerator];
        while (key=[myEnumerator3 nextObject])
        {
            if([key rangeOfString:@"ksyy"].length == 4){
                NSString *value = [NSString stringWithFormat:@"%@",[[UserInfo shareUserInfo].logUserSatate objectForKey:key]];
                if([@"1" isEqualToString:value]){
                    havePemission = YES;
                    break;
                }
                
            }
        }
        
        if(havePemission){
            ExamReservationController *kaoshiYuyueListController = [[ExamReservationController alloc] init];
            [self.navigationController pushViewController:kaoshiYuyueListController animated:YES];
        }
        else{
            [Utils showMessage:@"veservationNoPermssion"];
        }
    }];
    
    
}

-(IBAction)gotoServiceEvaluation:(id)sender{
    ReservationEvaluateListController *reservationEvaluateController = [[ReservationEvaluateListController alloc] init];
    [self.navigationController pushViewController:reservationEvaluateController animated:YES];
}

-(IBAction)gotoReservationHistory:(id)sender{
    ReservationHistoryListController *reservationHistoryListController = [[ReservationHistoryListController alloc] init];
    [self.navigationController pushViewController:reservationHistoryListController animated:YES];
}

-(void)gotoFlowInfo{
    FlowInfoViewController *flowInfoViewController = [[FlowInfoViewController alloc] init];
    [self.navigationController pushViewController:flowInfoViewController animated:YES];
}

-(IBAction)showLeftMenu:(id)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.leftMenuController showLeftMenu];
    
}

//刷新权限
-(void)refreshAuth:(void (^)(BOOL finished))completion1{
    //读取信息
    NSString *personalID = [[NSUserDefaults standardUserDefaults] objectForKey:@"PersonIdentify"];
    NSString *password = [WQUserDataManager readPassWord];
    if(![Utils isNullOrEmpty:personalID] && ![Utils isNullOrEmpty:password]){
        if(_loginRequest) [_loginRequest.webRequest clearDelegatesAndCancel];
        _loginRequest = [[GeneralWebRequest alloc] init];
        [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
        [_loginRequest requestLogin:personalID passWord:password successBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
            
            completion1(YES);
            
        } failedBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
        }];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
