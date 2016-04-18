//
//  KaoshiYuyueListController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ExamReservationController.h"
#import "ExamReservationCell.h"
#import "TabBarViewController.h"
#import "ActionView.h"
#import "MJExtension.h"

@interface ExamReservationController (){
    ActionView *actionView;
}

@end

@implementation ExamReservationController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"考试预约";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    [self requestData];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.nib = [UINib nibWithNibName:@"ExamReservationCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    actionView = [[[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:self options:nil] lastObject];
    actionView.titleLb.text = @"确定预约？";
    [actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    actionView.frame = CGRectMake(0, UISCREEN_SIZE.height, UISCREEN_SIZE.width, actionView.frame.size.height);
    __weak typeof(self) weakSelf = self;
    [actionView addClickBlock:^(NSInteger index) {
        if(index==0){
            [weakSelf actionClick:nil];
        }
        else{
            [weakSelf actionClick:nil];
            [weakSelf commit];
        }
    }];
    
    
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_ExamBook WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic in [resultDic objectForKey:@"Result"]){
            NSError *error;
            ExamReservationItem *item = [ExamReservationItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
        if(!self.dataAry.count){
            [Utils showMessage:@"noRevervationData"];
        }
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 335;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExamReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    
    ExamReservationItem *item = self.dataAry[indexPath.row];
    cell.carTypeLb.text = item.Chexing;
    cell.detailTypeLb.text = item.Kskm;
    cell.timeLb.text = item.Kssj;
    cell.addressLb.text = item.Ksdd;
    cell.totalNumLb.text = item.Ksrs;
    cell.leftNumLb.text = item.Syrs;
    
    return cell;
}

-(void)showAction:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:actionView];
    [tabbarVc.view bringSubviewToFront:actionView];
    
    if(tabbarVc.grayBtn.hidden){
        tabbarVc.grayBtn.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = actionView.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            actionView.frame = r;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    self.selectedExamReservationItem = self.dataAry[sender.tag];
}

-(IBAction)actionClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = actionView.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        actionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [actionView removeFromSuperview];
    }];
}

-(void)commit{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId",
                               self.selectedExamReservationItem.Ksjhid,@"ksjhId", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AddExam WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"reservationSuccess"];
        [self.navigationController popViewControllerAnimated:YES];
        
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
