//
//  TGViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "TGViewController.h"
#import "HomeViewController.h"
#import "SchoolDetailController.h"
#import "ReservationHomeController.h"
#import "TabBarViewController.h"
#import "PersonnalViewController.h"
#import "GeneralWebRequest.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "ReservationHistoryListController.h"
#import "MyConsumptionListController.h"
#import "MySuggestionController.h"
#import "FirstChangePasswordController.h"
#import "SettingViewController.h"

@interface TGViewController (){
    BOOL isLeftMenuShow;
    
    UIPanGestureRecognizer *panGesture;
    
    UISwipeGestureRecognizer *swipGesture;
    
    GeneralWebRequest *loginRequest;
}

@end
BOOL isMainViewDisplaying;
@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[SchoolDetailController alloc] init]];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[[ReservationHomeController alloc] init]];
    self.mainViewController = [[TabBarViewController alloc] init];
    self.mainViewController.viewControllers = @[nav1, nav2, nav3];
    self.mainViewController.leftMenuController = self;
    
    self.shadowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shadowBtn setTitle:@"" forState:UIControlStateNormal];
    [self.shadowBtn setFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, UISCREEN_SIZE.height)];
    [self.mainViewController.view addSubview:self.shadowBtn];
    self.shadowBtn.hidden = YES;
    self.shadowBtn.backgroundColor = [UIColor clearColor];
    [self.shadowBtn addTarget:self action:@selector(reverseMianPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.mainViewController];
    [self.view addSubview:self.mainViewController.view];
    [self.mainViewController.view setFrame:self.view.frame];
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGesture];
    panGesture.delegate = self;
    
    swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwip:)];
    swipGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipGesture];
    
    [panGesture requireGestureRecognizerToFail:swipGesture];
    
    //加阴影
    self.mainViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.mainViewController.view.layer.shadowOffset = CGSizeMake(-2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.mainViewController.view.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.mainViewController.view.layer.shadowRadius = 4;//阴影半径，默认3
    
    isMainViewDisplaying = YES;
    
    self.contentView.center = CGPointMake(self.view.center.x-100,self.view.center.y+30);
//    self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    //login view
    self.loginView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    [self.view addSubview:self.loginView];
    self.loginView.hidden = YES;
    self.loginView.backgroundColor = MAIN_VIEW_COLOR;
    self.loginView.layer.cornerRadius = 4;
    self.loginView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.loginView.layer.borderWidth = 0.5;
    [self.loginView.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.closeBtn addTarget:self action:@selector(closeLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.headerPicBtn.layer.borderColor = [UIColor whiteColor].CGColor;
     self.headerPicBtn.layer.borderWidth = 0.5;
     self.headerPicBtn.layer.cornerRadius = self.headerPicBtn.frame.size.width/2;
    self.headerPicBtn.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:Notification_Login_Success object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess) name:Notification_Logout_Success object:nil];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    [self changeStatus];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)changeStatus{
    if([UserInfo shareUserInfo].isLogin){
        self.loginBtn.hidden = YES;
        self.nameLb.hidden = NO;
        self.currentStateLb.hidden = NO;
    }
    else{
        self.loginBtn.hidden = NO;
        self.nameLb.hidden = YES;
        self.currentStateLb.hidden = YES;
    }
}

-(void)initData{
    self.controllers = [NSArray arrayWithObjects:
                        NSStringFromClass([PersonnalViewController class]),
                        NSStringFromClass([MyConsumptionListController class]),
                        NSStringFromClass([ReservationHistoryListController class]),
                        NSStringFromClass([MySuggestionController class]),nil];
}

-(void)showLeftMenu{
    [self defaultSetting];
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(curveOut2)];
    
    self.mainViewController.view.transform = CGAffineTransformMakeScale(0.7,0.7);
    CGPoint o = CGPointMake(UISCREEN_SIZE.width-70+self.mainViewController.view.frame.size.width/2, UISCREEN_SIZE.height/2);
    self.mainViewController.view.center = o;
    
    //content view
    self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    self.contentView.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    [UIView commitAnimations];
    self.shadowBtn.hidden = NO;
    
    
    
    isLeftMenuShow = YES;
}

-(void)reverseMianPage{
    [self.mainViewController.view bringSubviewToFront:self.shadowBtn];
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(curveOut2)];
    
    self.mainViewController.view.transform = CGAffineTransformMakeScale(1,1);
    self.mainViewController.view.center = self.view.center;
    
    //content view
    self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.contentView.center = CGPointMake(self.view.center.x-100, self.view.center.y+30);
    
    [UIView commitAnimations];
    self.shadowBtn.hidden = YES;
    
    isLeftMenuShow = NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint transPoint = [recognizer translationInView:self.view];
    
    
    if(!self.mainViewController.grayBtn.hidden) return;
    
    //总共要移动的距离
    CGFloat tl = UISCREEN_SIZE.width-70;
    
    
    static CGFloat startX = 0;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self defaultSetting];
            startX = 0;
            if(isLeftMenuShow){
                recognizer.enabled = NO;
                break;
            }
            if([recognizer locationInView:self.view].x > 80){
                recognizer.enabled = NO;
                break;
            }
            if(!isMainViewDisplaying){
                recognizer.enabled = NO;
                break;
            }
            
//            CLog(@"~~~%f",transPoint.x);
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if(transPoint.x < 0){
                self.mainViewController.view.transform = CGAffineTransformMakeScale(1,1);
                self.mainViewController.view.center = self.view.center;
                
                //content view
                self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                self.contentView.center = CGPointMake(self.view.center.x-100, self.view.center.y+30);
                break;
            };
            
            if(fabs(transPoint.x) <= tl){
                CGFloat scle = transPoint.x / tl ;
                CLog(@"scale-> %f",scle);
                CGPoint center = self.view.center;
                CGPoint o = CGPointMake(UISCREEN_SIZE.width-70+self.mainViewController.view.frame.size.width/2,
                                        UISCREEN_SIZE.height/2);
                CGFloat distantce = o.x-center.x;
                
                self.mainViewController.view.transform = CGAffineTransformMakeScale(1-0.3*scle, 1-0.3*scle);
                self.mainViewController.view.center = CGPointMake(center.x+distantce*scle, center.y);
                
                self.contentView.center = CGPointMake((self.view.center.x-100)+100*scle, (self.view.center.y+30)-30*scle);
                self.contentView.transform = CGAffineTransformMakeScale(0.8+0.2*scle, 0.8+0.2*scle);
                
                
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            if(transPoint.x <= 100){
                [self reverseMianPage];
            }
            else{
                [self showLeftMenu];
            }
            recognizer.enabled = YES;
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            if(transPoint.x <= 100){
                if(!isLeftMenuShow)
                    [self reverseMianPage];
                else
                    [self showLeftMenu];
            }
            else{
                [self showLeftMenu];
            }
            recognizer.enabled = YES;
            break;
        }
        case UIGestureRecognizerStateFailed:{
            if(transPoint.x <= 100){
                [self reverseMianPage];
            }
            else{
                [self showLeftMenu];
            }
            recognizer.enabled = YES;
            break;
        }
            
        default:
            break;
    }
    

}

-(void)handleSwip:(UISwipeGestureRecognizer *)recognizer{
    CGPoint locationPoint = [recognizer locationInView:self.view];
    CLog(@"%f",locationPoint.x);
    if(locationPoint.x > UISCREEN_SIZE.width-70){
        switch (recognizer.state) {
            case UIGestureRecognizerStateEnded:{
                if(isLeftMenuShow){
                    [self reverseMianPage];
                }
                
                break;
            }
                
            default:
                break;
        }
    }
    
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    return YES;
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//}


//我的消费
-(IBAction)Menuclick:(UIButton *)sender{
    if([UserInfo shareUserInfo].isLogin){
        NSString *className = self.controllers[sender.tag];
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        UINavigationController *nav = [self.mainViewController.viewControllers objectAtIndex:self.mainViewController.selectedIndex];
        [nav pushViewController:vc animated:YES];
        
        [self reverseMianPage];
    }
    else{
        [self reverseMianPage];
        
        //进行登录预操作
        self.mainViewController.grayBtn.hidden = NO;
        [self.mainViewController.view bringSubviewToFront:self.mainViewController.grayBtn];
        self.loginView.hidden = NO;
        [self.view bringSubviewToFront:self.loginView];
        self.loginView.center = self.view.center;
        
        self.loginFlag = sender.tag;
    }
}

-(IBAction)menuclick2:(id)sender{
    [self reverseMianPage];
    [self.mainViewController showCartypeSelect];
}

//登录！登录的地方有3处，tabbar，左菜单，tabbar里的自动登录
-(void)loginAction:(id)sender{
    [self.loginView removeHubProgressView];
    [self.loginView.userNameTf resignFirstResponder];
    [self.loginView.passWordTf resignFirstResponder];
    loginRequest = [[GeneralWebRequest alloc] init];
    [self.loginView addHubProgressView];
    [loginRequest requestLogin:self.loginView.userNameTf.text passWord:self.loginView.passWordTf.text successBlock:^(NSDictionary *resultDic) {
        [self closeLogin:nil];
        [self.loginView removeHubProgressView];
        [self.loginView clearInputInfo];
        
        if([[UserInfo shareUserInfo].mobile isEqualToString:[WQUserDataManager readPassWord]]){
            UINavigationController *navi = [self.mainViewController.viewControllers objectAtIndex:self.mainViewController.selectedIndex];
            FirstChangePasswordController *changePassword = [[FirstChangePasswordController alloc] init];
            changePassword.hideBackBtn = YES;
            [navi pushViewController:changePassword animated:YES];
        }
        else{
            NSString *className = self.controllers[self.loginFlag];
            UIViewController *vc = [[NSClassFromString(className) alloc] init];
            UINavigationController *nav = [self.mainViewController.viewControllers objectAtIndex:self.mainViewController.selectedIndex];
            [nav pushViewController:vc animated:YES];
        }
        
        
       
        
        
    } failedBlock:^(NSDictionary *resultDic) {
        [self.loginView removeHubProgressView];
    }];
    
}

-(void)closeLogin:(id)sender{
    self.loginView.hidden = YES;
    self.mainViewController.grayBtn.hidden = YES;
}

-(void)loginSuccess{
    self.nameLb.text = [UserInfo shareUserInfo].name;
    self.currentStateLb.text = [UserInfo shareUserInfo].currentState;
    [self.headerPicBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[UserInfo shareUserInfo].appHeadPic]]
                             forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head_pic"] options:SDWebImageRefreshCached];
    [self changeStatus];
}

-(void)logoutSuccess{
    self.nameLb.text = @"未登录";
    self.currentStateLb.text = @"";
    [self.headerPicBtn setBackgroundImage:[UIImage imageNamed:@"head_pic"] forState:UIControlStateNormal];
    [self changeStatus];
}

-(IBAction)setting:(id)sender{
    UIViewController *vc = [[SettingViewController alloc] init];
    UINavigationController *nav = [self.mainViewController.viewControllers objectAtIndex:self.mainViewController.selectedIndex];
    [nav pushViewController:vc animated:YES];
    
    [self reverseMianPage];
}

-(void)defaultSetting{
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:key_user_selected_car_type];
    if(!i) i = 0;
    
    switch (i) {
        case 1:
            [self.cartypeBtn setTitle:@"小车" forState:UIControlStateNormal];
            break;
        case 3:
            [self.cartypeBtn setTitle:@"货车" forState:UIControlStateNormal];
            break;
        case 4:
            [self.cartypeBtn setTitle:@"客车" forState:UIControlStateNormal];
            break;
        case 5:
            [self.cartypeBtn setTitle:@"摩托车" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
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
