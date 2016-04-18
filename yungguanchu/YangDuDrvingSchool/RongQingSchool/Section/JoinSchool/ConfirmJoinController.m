//
//  ConfirmJoinController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/8.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ConfirmJoinController.h"
#import "TabBarViewController.h"
@interface ConfirmJoinController ()

@end

@implementation ConfirmJoinController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    [self initView];
}

-(void)initView{
    self.moneyLb.text = [NSString stringWithFormat:@"￥%@",self.totalMoney];
    
    self.actionView = [[[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:self options:nil] lastObject];
    self.actionView.titleLb.text = @"确定报名吗？";
    [self.actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView.frame = CGRectMake(0, UISCREEN_SIZE.height, UISCREEN_SIZE.width, self.actionView.frame.size.height);
    WS(weakSelf);
    [self.actionView addClickBlock:^(NSInteger index) {
        if(index==0){
            [weakSelf actionClick:nil];
        }
        else{
            [weakSelf actionClick:nil];
            [weakSelf commit:nil];
        }
    }];
    
    self.actionView2 = [[[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:self options:nil] lastObject];
    self.actionView2.titleLb.text = @"报名成功";
    self.actionView2.descLb.text = @"请到驾校缴费完成报名";
    [self.actionView2.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView2.frame = CGRectMake(0, UISCREEN_SIZE.height, UISCREEN_SIZE.width, self.actionView2.frame.size.height);
    
    [self.actionView2 addClickBlock:^(NSInteger index) {
        if(index==0){
            [weakSelf actionClick1:nil];
        }
        else{
            [weakSelf actionClick1:nil];
        }
    }];
    
}

//显示确认action
-(IBAction)showAction:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.actionView];
    [tabbarVc.view bringSubviewToFront:self.actionView];
    
    tabbarVc.grayBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.actionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.actionView.frame = r;
        
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏确认action
-(IBAction)actionClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.actionView.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        self.actionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.actionView removeFromSuperview];
    }];
}

//显示确认action2
-(IBAction)showAction1:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.actionView2];
    [tabbarVc.view bringSubviewToFront:self.actionView2];
    
    tabbarVc.grayBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.actionView2.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.actionView2.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = NO;
    }];
}

//隐藏确认action2
-(IBAction)actionClick1:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    tabbarVc.grayBtn.hidden = YES;
    [self.actionView2 removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)commit:(id)sender{
    if(self.commitRequet)[self.commitRequet clearDelegatesAndCancel];
    self.commitRequet = [[WebRequest alloc] init];
    self.commitRequet.imageAry = _images;
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.commitRequet requestPostWithAction:Action_OnlineRegis WithParameter:_postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [self showAction1:nil];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
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
