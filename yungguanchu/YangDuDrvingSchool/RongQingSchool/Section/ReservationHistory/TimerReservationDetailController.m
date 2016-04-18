//
//  NormalReservationDetailController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "TimerReservationDetailController.h"
#import "NormalReservationDetailCell.h"
#import "TabBarViewController.h"
#import "MJExtension.h"
#import "TimerReservationHeaderCell.h"
#import "TimerReservationBodyCell.h"

@interface TimerReservationDetailController ()

@end

@implementation TimerReservationDetailController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"培训预约详情";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    
    [self requestData];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.nib = [UINib nibWithNibName:@"NormalReservationDetailCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.bounces = NO;
    
    self.nib0 = [UINib nibWithNibName:NSStringFromClass([TimerReservationHeaderCell class]) bundle:nil];
    [self.tableView registerNib:self.nib0 forCellReuseIdentifier:@"cellid0"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nib1 = [UINib nibWithNibName:NSStringFromClass([TimerReservationBodyCell class]) bundle:nil];
    [self.tableView registerNib:self.nib1 forCellReuseIdentifier:@"cellid1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //退费
    self.returnActionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ReturnMoneyAction class]) owner:self options:nil] lastObject];
    self.returnActionView.titleLb.text = @"退约原因";
    self.returnActionView.placeholderLb.text = @"请输入退约原因";
    self.returnActionView.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.returnActionView.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    __weak typeof(self) weakSelf = self;
    [self.returnActionView addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick:index];
        }
        else{
            
            
            if([Utils isNullOrEmpty:weakSelf.returnActionView.inputTv.text]){
                [weakSelf.returnActionView.inputTv resignFirstResponder];
                
                [Utils showMessage:@"pleaseInputReturnVeservationReason"];
            }
            else{
                [weakSelf actionClick:index];
            }
            
        }
    }];
    
    //确定退费
    self.actionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ActionView class]) owner:self options:nil] lastObject];
    self.actionView.titleLb.text = @"确定退约吗？";
    self.actionView.descLb.text = @"提前24小时可以退约";
    [self.actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.actionView.frame.size.height);
    [self.actionView addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick1:nil];
        }
        else{
            [weakSelf actionClick1:nil];
            [weakSelf returnMoneyComit];
        }
    }];
    
    [self relayoutTableview];
}

-(void)relayoutTableview{
    CGRect r = self.tableview.frame;
    r.size.height = 45*self.dataAry.count;
    self.tableview.frame = r;
    
    r = self.tableBgview.frame;
    r.size.height = self.tableview.frame.size.height;
    self.tableBgview.frame = r;
    
    r = self.bottomLine.frame;
    r.origin.y = self.tableBgview.frame.size.height-1;
    self.bottomLine.frame = r;
    
    self.bgScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.tableBgview.frame)+15);
    
    CGPoint p = self.timeTitleLb.center;
    p.y = self.tableview.center.y;
    self.timeTitleLb.center = p;
    
    r = self.timeTitleVerticalPic.frame;
    r.origin.y = 11;
    r.size.height = self.tableview.frame.size.height - 22;
    self.timeTitleVerticalPic.frame = r;
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               self.currentReservationItem.OrderType,@"ortype", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_OrderDetail WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        NSDictionary *dic = [[resultDic objectForKey:@"Result"] objectForKey:@"PxOrderDetail"];
        self.typeLb.text = [dic objectForKey:@"PxNum"];
        self.timeLb.text = [dic objectForKey:@"PxDate"];
        self.stateLb.text = [dic objectForKey:@"PxState"];
        self.coachLb.text = [dic objectForKey:@"PxCoach"];
        self.genderLb.text = [dic objectForKey:@"PxCoachGender"];
        self.groupLb.text = [dic objectForKey:@"PxCoachKeshi"];
        self.jiaolingLb.text = [dic objectForKey:@"PxCoachTeachingAge"];
        
        self.pxOrderDetailDic = dic;
        
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic2 in [dic objectForKey:@"PxSoltList"]){
            NSError *error;
            PxSoltListItem *item = [PxSoltListItem objectWithKeyValues:dic2 error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        
        /*
        [self.tableview reloadData];
        [self relayoutTableview];
         */
        
        [self.tableView reloadData];
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 115;
    }
    else{
        return 240;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        if(indexPath.row == 0){
            TimerReservationHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid0"];
            cell.nameLb.text = self.pxOrderDetailDic[@"PxNum"];
            cell.statusLb.text = self.pxOrderDetailDic[@"PxState"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            TimerReservationBodyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
            PxSoltListItem *item = self.dataAry[indexPath.row-1];
            cell.yysjLb.text = item.PxDetailTime;
            cell.jlxmLb.text = item.jlxm;
            cell.jldhLb.text = item.jldh;
            cell.jlchLb.text = item.jlch;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.returnMoneyBtn.tag = indexPath.row-1;
            [cell.returnMoneyBtn addTarget:self action:@selector(rebackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.returnMoneyBtn setTitle:item.PxCanCancel forState:UIControlStateNormal];
            if([@"0" isEqualToString:item.PxSoltState]){
                [cell.returnMoneyBtn setBackgroundImage:[UIImage imageNamed:@"blue_border_nomarl"] forState:UIControlStateNormal];
                [cell.returnMoneyBtn setTitleColor:UIColorFromRGB(3, 180, 248) forState:UIControlStateNormal];
                cell.returnMoneyBtn.userInteractionEnabled = YES;
            }
            else{
                [cell.returnMoneyBtn setBackgroundImage:[UIImage imageNamed:@"btn_bule_p"] forState:UIControlStateNormal];
                [cell.returnMoneyBtn setTitleColor:UIColorFromRGB(190, 190, 190) forState:UIControlStateNormal];
                cell.returnMoneyBtn.userInteractionEnabled = NO;
            }
            
            return cell;
        }
    }
    else{
        return nil;
    }
    NormalReservationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rebackBtn.tag = indexPath.row;
    [cell.rebackBtn addTarget:self action:@selector(rebackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    PxSoltListItem *item = self.dataAry[indexPath.row];
    cell.timeLb.text = [item.PxDetailTime substringFromIndex:5];
    [cell.rebackBtn setTitle:item.PxCanCancel forState:UIControlStateNormal];
    if([@"0" isEqualToString:item.PxSoltState]){
        [cell.rebackBtn setBackgroundImage:[UIImage imageNamed:@"blue_border_nomarl"] forState:UIControlStateNormal];
        [cell.rebackBtn setTitleColor:UIColorFromRGB(3, 180, 248) forState:UIControlStateNormal];
        cell.rebackBtn.userInteractionEnabled = YES;
    }
    else{
        [cell.rebackBtn setBackgroundImage:[UIImage imageNamed:@"btn_bule_p"] forState:UIControlStateNormal];
        [cell.rebackBtn setTitleColor:UIColorFromRGB(190, 190, 190) forState:UIControlStateNormal];
        cell.rebackBtn.userInteractionEnabled = NO;
    }
    
    return cell;
}

//显示退费输入框
-(void)rebackBtnClick:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:_returnActionView];
    [tabbarVc.view bringSubviewToFront:_returnActionView];
    
    if(tabbarVc.grayBtn.hidden){
        tabbarVc.grayBtn.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = _returnActionView.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            _returnActionView.frame = r;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    self.currentPxSoltListItem = self.dataAry[sender.tag];
}

//隐藏退费输入框action
-(void)actionClick:(NSInteger)tag{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = _returnActionView.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        _returnActionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [_returnActionView removeFromSuperview];
        if(tag == 1){
            [self rebackConfirmClick:nil];
        }
    }];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    CGFloat t = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:t];
    CGRect r = self.returnActionView.frame;
    r.origin.y =  y-self.returnActionView.frame.size.height;
    self.returnActionView.frame = r;
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notif{
    
    CGFloat t = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:t];
    CGRect r = self.returnActionView.frame;
    r.origin.y =  self.tabBarController.view.frame.size.height-self.returnActionView.frame.size.height;
    self.returnActionView.frame = r;
    
    [UIView commitAnimations];
}

//显示退费确认action
-(void)rebackConfirmClick:(UIButton *)sender{
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

//隐藏确认退费action
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

-(void)returnMoneyComit{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.currentPxSoltListItem.TranOrderId,@"orid",
                               self.returnActionView.inputTv.text,@"canrea", nil];
    
    if(self.returnRequest) [self.returnRequest clearDelegatesAndCancel];
    self.returnRequest = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.returnRequest requestGetWithAction:Action_CanTraOrd WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"reservationCancleSuccess"];
        [self requestData];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
        _returnActionView.inputTv.text = @"";
        
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
