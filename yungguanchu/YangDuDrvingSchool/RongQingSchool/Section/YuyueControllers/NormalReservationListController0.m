//
//  NormalReservationListController0.m
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//
#import "NormalReservationListController.h"
#import "NormalReservationListController0.h"
#import "NormalReservationCell.h"
#import "MJExtension.h"
#import "TabBarViewController.h"

@interface NormalReservationListController0 ()

@end

@implementation NormalReservationListController0
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分车计划";
    self.navigationItem.leftBarButtonItems = [self.navigationController getSmallBackButtons];
    [self initView];
    [self requestData];
}

-(void)initView{
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
    self.nib = [UINib nibWithNibName:@"NormalReservationCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    //是否选择教练action
    self.coachSelectAction = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CoachSelectAction class]) owner:self options:nil] lastObject];
    [self.coachSelectAction.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.coachSelectAction.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.coachSelectAction.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.coachSelectAction.frame.size.height);
    [self.coachSelectAction addClickBlock:^(NSInteger index, NSInteger selectedTag) {
        if(index == 0){
            [weakSelf actionClick1:nil];
        }
        else{
            [weakSelf actionClick1:nil];
            //不指定教练
            if(selectedTag == 0){
                [weakSelf commitReservation];
            }
            //指定教练
            else{
                [weakSelf gotoNormalReservation];
            }
        }
    }];
    
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId", nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_FenCheJH WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"Result"]){
            NSError *error;
            NormalReservationItem0 *item = [NormalReservationItem0 objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        [self.tableview reloadData];
        
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 286;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NormalReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NormalReservationItem0 *item = self.dataAry[indexPath.row];
    cell.carTypeLb.text = item.chexing;
    cell.subjectTypeLb.text = item.sType;
    cell.timeLb.text = item.fencheTime;
    cell.totalNumLb.text = item.maxNum;
    cell.leftNumLb.text = item.leftNum;
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

//不指定教练，直接预约
-(void)commitReservation{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId",
                               self.selectedNormalReservationItem0.xid,@"jhid",
                               @"",@"Jlid", nil];
    
    if(self.reservationRequest){
        [self.reservationRequest clearDelegatesAndCancel];
    }
    self.reservationRequest = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.reservationRequest requestGetWithAction:Action_FenCheYY WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"reservationSuccess"];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
    }];
}

//跳转到教练列表
-(void)gotoNormalReservation{
    NormalReservationListController *normalReservationController = [[NormalReservationListController alloc] init];
    normalReservationController.xid = self.selectedNormalReservationItem0.xid;
    normalReservationController.strsearch = self.selectedNormalReservationItem0.sType;
    [self.navigationController pushViewController:normalReservationController animated:YES];
}

//弹出action
-(void)actionClick:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.coachSelectAction];
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.view bringSubviewToFront:self.coachSelectAction];
    [self.coachSelectAction setNeedsLayout];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.coachSelectAction.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.coachSelectAction.frame = r;
    } completion:^(BOOL finished) {
        
    }];
    
    self.selectedNormalReservationItem0 = self.dataAry[sender.tag];
}

//隐藏action
-(void)actionClick1:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.coachSelectAction.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        self.coachSelectAction.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.coachSelectAction removeFromSuperview];
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
