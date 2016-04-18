//
//  TabBarViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "TabBarViewController.h"
#import "TGViewController.h"
#import "GeneralWebRequest.h"
#import "FirstChangePasswordController.h"
#import "UIAlertView+XY.h"

@interface TabBarViewController (){
    GeneralWebRequest *loginRequest;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.grayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.grayBtn.frame = CGRectMake(0, 0, UISCREEN_SIZE.width, UISCREEN_SIZE.height);
    self.grayBtn.backgroundColor = [UIColor grayColor];
    self.grayBtn.alpha = 0.4;
    
    [self.view addSubview:self.grayBtn];
    self.grayBtn.hidden = YES;

    [self layoutTabBar];
    
    self.loginView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    [self.view addSubview:self.loginView];
    self.loginView.hidden = YES;
    self.loginView.layer.cornerRadius = 4;
    self.loginView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.loginView.layer.borderWidth = 0.5;
    [self.loginView.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.closeBtn addTarget:self action:@selector(closeLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    //选择车型view
    self.settingCartypeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SettingCarType class]) owner:self options:nil] lastObject];
    [self.view addSubview:self.settingCartypeView];
    self.settingCartypeView.hidden = YES;
    self.settingCartypeView.layer.cornerRadius = 4;
    self.settingCartypeView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.settingCartypeView.layer.borderWidth = 0.5;
    __weak typeof(self) weakSelf = self;
    [self.settingCartypeView addClickBlock:^(NSInteger index) {
        //进行登录操作
        weakSelf.grayBtn.hidden = YES;
        weakSelf.settingCartypeView.hidden = YES;
    }];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"car_selected"]){
        [self showCartypeSelect];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"car_selected"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self requestVersionInfo];
    
    //自动登录
    [self relogin];
    
    //监听需要重新登录的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin) name:Notification_Need_Relogin object:nil];
}

-(void)layoutTabBar{
    
    
    self.tabbarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 49)];
    self.tabbarBgView.backgroundColor = [UIColor grayColor];
    
    UIImageView *tbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 49)];
    tbImageView.image = [UIImage imageNamed:@"tabBgImage"];
    [self.tabbarBgView addSubview:tbImageView];
    
    /*
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(0, 0, UISCREEN_SIZE.width/3, 49);
    [b1 setTitle:@"button1" forState:UIControlStateNormal];
    [b1 setTitleColor:UIColorFromRGB(0, 0, 0) forState:UIControlStateNormal];
    [self.tabbarView addSubview:b1];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(UISCREEN_SIZE.width/3, 0, UISCREEN_SIZE.width/3, 49);
    [b2 setTitleColor:UIColorFromRGB(0, 0, 0) forState:UIControlStateNormal];
    [b2 setTitle:@"button2" forState:UIControlStateNormal];
    [self.tabbarView addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    b3.frame = CGRectMake(UISCREEN_SIZE.width/3*2, 0, UISCREEN_SIZE.width/3, 49);
    [b3 setTitle:@"button3" forState:UIControlStateNormal];
    [b3 setTitleColor:UIColorFromRGB(0, 0, 0) forState:UIControlStateNormal];
    [self.tabbarView addSubview:b3];
     */
    
    self.tabbarView1 = [[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil] lastObject];
    self.tabbarView1.tag = 0;
    self.tabbarView1.frame = CGRectMake((UISCREEN_SIZE.width/3-self.tabbarView1.frame.size.width)/2,
                                       self.tabbarView1.frame.origin.y,
                                       self.tabbarView1.frame.size.width,
                                       self.tabbarView1.frame.size.height);
    self.tabbarView1.iconLb.text = @"报名";
    [self.tabbarView1 addTarget:self action:@selector(tabbarSelectd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tabbarView2 = [[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil] lastObject];
    self.tabbarView2.tag = 1;
    self.tabbarView2.frame = CGRectMake((UISCREEN_SIZE.width/3-self.tabbarView2.frame.size.width)/2+UISCREEN_SIZE.width/3,
                                        self.tabbarView2.frame.origin.y,
                                        self.tabbarView2.frame.size.width,
                                        self.tabbarView2.frame.size.height);
    self.tabbarView2.iconLb.text = @"驾考";
    [self.tabbarView2 addTarget:self action:@selector(tabbarSelectd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tabbarView3 = [[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil] lastObject];
    self.tabbarView3.tag = 2;
    self.tabbarView3.frame = CGRectMake((UISCREEN_SIZE.width/3-self.tabbarView3.frame.size.width)/2+UISCREEN_SIZE.width/3*2,
                                        self.tabbarView3.frame.origin.y,
                                        self.tabbarView3.frame.size.width,
                                        self.tabbarView3.frame.size.height);
    self.tabbarView3.iconLb.text = @"预约";
    [self.tabbarView3 addTarget:self action:@selector(tabbarSelectd:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabbarBgView addSubview:self.tabbarView1];
    [self.tabbarBgView addSubview:self.tabbarView2];
    [self.tabbarBgView addSubview:self.tabbarView3];
    
    [self tabbarSelectd:self.tabbarView1];
    
    [self.tabBar addSubview:self.tabbarBgView];
    [self.tabBar bringSubviewToFront:self.tabbarBgView];
}

-(void)tabbarSelectd:(TabBarView *)tabbarView{
    
    if(tabbarView == self.tabbarView3){
        if([UserInfo shareUserInfo].isLogin){
            
        }
        else{
            //进行登录操作
            self.grayBtn.hidden = NO;
            self.loginView.hidden = NO;
            [self.view bringSubviewToFront:self.grayBtn];
            [self.view bringSubviewToFront:self.loginView];
            self.loginView.center = self.view.center;
            
            return;
        }
    }
    
    for(TabBarView *tabarV in @[self.tabbarView1,self.tabbarView2,self.tabbarView3]){
        if(tabbarView == tabarV){
            tabarV.iconIm.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar%ld_select",(long)tabarV.tag]];
            tabarV.iconLb.textColor = UIColorFromRGB(0, 181, 247);
        }
        else{
            tabarV.iconIm.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar%ld_unselect",(long)tabarV.tag]];
            tabarV.iconLb.textColor = UIColorFromRGB(154, 155, 150);

        }
    }
    
    self.selectedIndex = tabbarView.tag;
    [self.tabBar bringSubviewToFront:self.tabbarBgView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.tabbarBgView];
}

//登录 ！登录的地方有3处，tabbar，左菜单，tabbar里的自动登录
-(void)loginAction:(id)sender{
    [self.loginView removeHubProgressView];
    [self.loginView.userNameTf resignFirstResponder];
    [self.loginView.passWordTf resignFirstResponder];
    if(loginRequest) [loginRequest.webRequest clearDelegatesAndCancel];
    loginRequest = [[GeneralWebRequest alloc] init];
    [self.loginView addHubProgressView];
    [loginRequest requestLogin:self.loginView.userNameTf.text passWord:self.loginView.passWordTf.text successBlock:^(NSDictionary *resultDic) {
        [self closeLogin:nil];
        [self.loginView removeHubProgressView];
        [self.loginView clearInputInfo];
        if([[UserInfo shareUserInfo].mobile isEqualToString:[WQUserDataManager readPassWord]]){
            UINavigationController *navi = self.viewControllers[self.selectedIndex];
            FirstChangePasswordController *changePassword = [[FirstChangePasswordController alloc] init];
            changePassword.hideBackBtn = YES;
            [navi pushViewController:changePassword animated:YES];
        }
        else{
            [self tabbarSelectd:self.tabbarView3];
        }
        
        
    } failedBlock:^(NSDictionary *resultDic) {
        [self.loginView removeHubProgressView];
    }];
}

-(void)requestVersionInfo{
    if(self.versionRequest) [self.versionRequest.webRequest clearDelegatesAndCancel];
    self.versionRequest = [[GeneralWebRequest alloc] init];
    
    [self.versionRequest requestVersionInfoSuccessBlock:^(NSDictionary *resultDic) {
        CLog(@"%@",resultDic);
        
    } failedBlock:^(NSDictionary *resultDic) {
        
    }];
}

-(void)closeLogin:(id)sender{
    self.loginView.hidden = YES;
    self.grayBtn.hidden = YES;
}

//重新登录、自动登录 ！登录的地方有3处，tabbar，左菜单，tabbar里的自动登录
-(void)relogin{
    //读取信息
    NSString *personalID = [[NSUserDefaults standardUserDefaults] objectForKey:@"PersonIdentify"];
    NSString *password = [WQUserDataManager readPassWord];
    if(![Utils isNullOrEmpty:personalID] && ![Utils isNullOrEmpty:password]){
        if(loginRequest) [loginRequest.webRequest clearDelegatesAndCancel];
        loginRequest = [[GeneralWebRequest alloc] init];
        [self.loginView addHubProgressView];
        [loginRequest requestLogin:personalID passWord:password successBlock:^(NSDictionary *resultDic) {
            [self.loginView removeHubProgressView];
            if([[UserInfo shareUserInfo].mobile isEqualToString:[WQUserDataManager readPassWord]]){
                UINavigationController *navi = self.viewControllers[self.selectedIndex];
                FirstChangePasswordController *changePassword = [[FirstChangePasswordController alloc] init];
                changePassword.hideBackBtn = YES;
                [navi pushViewController:changePassword animated:YES];
            }
            else{
                
            }
        } failedBlock:^(NSDictionary *resultDic) {
            [self.loginView removeHubProgressView];
        }];
    }
}

-(void)showCartypeSelect{
    self.grayBtn.hidden = NO;
    self.settingCartypeView.hidden = NO;
    [self.view bringSubviewToFront:self.grayBtn];
    [self.view bringSubviewToFront:self.settingCartypeView];
    self.settingCartypeView.center = self.view.center;
    [self.settingCartypeView setNeedsLayout];
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
