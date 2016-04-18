//
//  PayForTimerYuyueController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "PayForTimerReservationController.h"
#import "PayForTimerCell.h"
#import "TabBarViewController.h"
@interface PayForTimerReservationController ()

@end

@implementation PayForTimerReservationController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectSoltListItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayForTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SoltlistItem *soltlistItem = self.selectSoltListItems[indexPath.row];
    
    cell.dateLb.text = soltlistItem.Orderdate;
    cell.timeLb.text = soltlistItem.Timesolt;
    
    if(![Utils isNullOrEmpty:soltlistItem.fxrs] && soltlistItem.fxrs.integerValue){
        cell.timeLb.text = [NSString stringWithFormat:@"%@ 可预约%@人剩余%@人",soltlistItem.Timesolt,soltlistItem.fxrs,soltlistItem.syrs];
    }
    
    return cell;
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.actionView = [[[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:self options:nil] lastObject];
    self.actionView.titleLb.text = @"确定预约？";
    [self.actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView.frame = CGRectMake(0, UISCREEN_SIZE.height, UISCREEN_SIZE.width, self.actionView.frame.size.height);
    __weak typeof(self) weakSelf = self;
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
    self.actionView2.titleLb.text = @"预约成功";
    self.actionView2.descLb.text = @"请按时到达培训地点";
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
    
    self.nib = [UINib nibWithNibName:@"PayForTimerCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview reloadData];
    
    self.moneyLb.text = self.totalMoney;
    self.coachNameLb.text = [NSString stringWithFormat:@"教练: %@",self.coachName];
    
    CGRect r = self.tableview.frame;
    r.size.height = MIN(self.tableview.contentSize.height, UISCREEN_SIZE.height-191-64);
    self.tableview.frame = r;
    
    r = self.moneyBgView.frame;
    r.origin.y = CGRectGetMaxY(self.tableview.frame);
    self.moneyBgView.frame = r;
    
    r = self.tableBgView.frame;
    r.size.height = CGRectGetMaxY(self.moneyBgView.frame);
    self.tableBgView.frame = r;
    
    r = self.okBtn.frame;
    r.origin.y = CGRectGetMaxY(self.tableBgView.frame)+13;
    self.okBtn.frame = r;
    
}

-(void)commit:(id)sender{
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AddTrainingbook WithParameter:self.postParam successBlock:^(NSDictionary *resultDic) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
        [Utils removeProgressHUB:self.view];
        [self showAction1:nil];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
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
