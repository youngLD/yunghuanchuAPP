//
//  NormalReservationDetailController2.m
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "NormalReservationDetailController.h"
#import "TabBarViewController.h"
@interface NormalReservationDetailController ()

@end

@implementation NormalReservationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.view.backgroundColor = MAIN_VIEW_COLOR;

    [self initViews];
    
    [self requestData];
}

-(void)initViews{
    
    if([self.currentReservationItem.OrderType rangeOfString:@"ks"].length){
        self.title = @"考试预约详情";
    }
    else if([self.currentReservationItem.OrderType rangeOfString:@"fc"].length){
        self.title = @"分车预约详情";
    }
    
    //确定退约
    __weak typeof(self) weakSelf = self;
    self.actionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ActionView class]) owner:self options:nil] lastObject];
    self.actionView.titleLb.text = @"确定退约吗？";
    self.actionView.descLb.text = @"";
    [self.actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.actionView.frame.size.height);
    [self.actionView addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick1:nil];
        }
        else{
            [weakSelf actionClick1:nil];
            [weakSelf returnMoney];
        }
    }];
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               self.currentReservationItem.OrderType,@"ortype", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_OrderDetail WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        if([self.currentReservationItem.OrderType rangeOfString:@"ks"].length){
            self.dataDic = [[resultDic objectForKey:@"Result"] objectForKey:@"KsOrderDetail"];
            [self initkaoshiView];
        }
        else if([self.currentReservationItem.OrderType rangeOfString:@"fc"].length){
            self.dataDic = [[resultDic objectForKey:@"Result"] objectForKey:@"FcOrderDetail"];
            [self initfencheView];
        }
        
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(void)initfencheView{
    /*
     "FcCoach": "0001",
     "FcCoachGender": "男",
     "FcCoachKeshi": "一中队",
     "FcDate": "2015/9/5",
     "FcNum": "科目二",
     "FcState": "审核通过"
     */
    
    self.titleLb0.text = @"预约科目";
    self.titleLb1.text = @"预约时间";
    self.titleLb2.text = @"当前状态";
    self.titleLb3.text = @"预约教练";
    self.titleLb4.text = @"性别";
    self.titleLb5.text = @"所属中队";
    
    self.contentLb0.text = [self.dataDic objectForKey:@"FcNum"];
    self.contentLb1.text = [self.dataDic objectForKey:@"FcDate"];
    self.contentLb2.text = [self.dataDic objectForKey:@"FcState"];
    self.contentLb3.text = [self.dataDic objectForKey:@"FcCoach"];
    self.contentLb4.text = [self.dataDic objectForKey:@"FcCoachGender"];
    self.contentLb5.text = [self.dataDic objectForKey:@"FcCoachKeshi"];
}

-(void)initkaoshiView{
    /*
     "KsNum": "科目一考试",
     "KsPosition": "",
     "KsTime": "2015/8/13 0:00:00",
     "KsType": "C1",
     "MyProperty": "已审核",
     "ksPeopleNum": "50"
     */
    
    self.titleLb0.text = @"驾考类型";
    self.titleLb1.text = @"考试科目";
    self.titleLb2.text = @"考试时间";
    self.titleLb3.text = @"考试地点";
    self.titleLb4.text = @"考试人数";
    self.titleLb4.text = @"预约状态";
    
    self.contentLb0.text = [self.dataDic objectForKey:@"KsType"];
    self.contentLb1.text = [self.dataDic objectForKey:@"KsNum"];
    self.contentLb2.text = [self.dataDic objectForKey:@"KsTime"];
    self.contentLb3.text = [self.dataDic objectForKey:@"KsPosition"];
    self.contentLb4.text = [self.dataDic objectForKey:@"ksPeopleNum"];
    self.contentLb5.text = [self.dataDic objectForKey:@"MyProperty"];
}

//隐藏action
-(void)actionClick1:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = _actionView.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        _actionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [_actionView removeFromSuperview];
    }];
}


-(IBAction)returnMoneyConfirm:(id)sender{

    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:_actionView];
    [tabbarVc.view bringSubviewToFront:_actionView];
    
    if(tabbarVc.grayBtn.hidden){
        tabbarVc.grayBtn.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = _actionView.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            _actionView.frame = r;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

-(void)returnMoney{
    if([self.currentReservationItem.OrderType rangeOfString:@"ks"].length){
        NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UserInfo shareUserInfo].uId,@"studentId",
                                   [self.dataDic objectForKey:@"KsTime"],@"jhsj", nil];
        
        if(self.returnRequest) [self.returnRequest clearDelegatesAndCancel];
        self.returnRequest = [[WebRequest alloc] init];
        [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
        [self.returnRequest requestGetWithAction:Action_CancleExambook WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
            
            [Utils removeProgressHUB:self.view];
            [Utils showMessage:@"reservationCancleSuccess"];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failedBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
        }];
        
    }
    else if([self.currentReservationItem.OrderType rangeOfString:@"fc"].length){
        
        NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UserInfo shareUserInfo].uId,@"studentId",
                                   [self.dataDic objectForKey:@"FcDate"],@"jhsj", nil];
        
        if(self.returnRequest) [self.returnRequest clearDelegatesAndCancel];
        self.returnRequest = [[WebRequest alloc] init];
        [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
        [self.returnRequest requestGetWithAction:Action_FenCheQX WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
            
            [Utils removeProgressHUB:self.view];
            [Utils showMessage:@"reservationCancleSuccess"];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failedBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
        }];
    }
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
