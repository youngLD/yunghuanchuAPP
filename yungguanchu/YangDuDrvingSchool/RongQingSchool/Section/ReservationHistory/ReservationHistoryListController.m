//
//  ReservationHistoryListController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ReservationHistoryListController.h"
#import "TabBarViewController.h"
#import "CurrentReservationCell.h"
#import "EndReservationCell.h"
#import "TimerReservationDetailController.h"
#import "NormalReservationDetailController.h"
#import "MJExtension.h"

@interface ReservationHistoryListController ()

@end

@implementation ReservationHistoryListController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约查询";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self requestData];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.nib0 = [UINib nibWithNibName:@"CurrentReservationCell" bundle:nil];
    [self.tableview registerNib:self.nib0 forCellReuseIdentifier:@"cellid0"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    self.nib1 = [UINib nibWithNibName:@"EndReservationCell" bundle:nil];
    self.nib2 = [UINib nibWithNibName:@"EndReservationCell2" bundle:nil];
    [self.tableview registerNib:self.nib1 forCellReuseIdentifier:@"cellid1"];
    [self.tableview registerNib:self.nib2 forCellReuseIdentifier:@"cellid2"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //退费
    self.returnMoneyActionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ReturnMoneyAction class]) owner:self options:nil] lastObject];
    self.returnMoneyActionView.titleLb.text = @"退费原因";
    self.returnMoneyActionView.placeholderLb.text = @"请输入退费原因";
    self.returnMoneyActionView.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.returnMoneyActionView.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    WS(weakSelf);
    [self.returnMoneyActionView addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick:index];
        }
        else{
            if([Utils isNullOrEmpty:weakSelf.returnMoneyActionView.inputTv.text]){
                [Utils showMessage:@"pleaseInputReturnMoneyReason"];
            }
            else{
                [weakSelf actionClick:index];
                [weakSelf returnMoneyComit];
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
    
    //评价
    self.evaluationActionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationAction1 class]) owner:self options:nil] lastObject];
    self.evaluationActionView.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.evaluationActionView.frame.size.height);
    
    [self.evaluationActionView addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf evaluationHideClick:nil];
        }
        else{
            if(weakSelf.evaluationActionView.star0<1){
                [Utils showMessage:@"startIsMust"];
            }
            else{
                [weakSelf evaluationHideClick:nil];
                [weakSelf commitEvaluation:weakSelf.evaluationActionView.star0];
            }
        }
    }];
    
    
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_QueryOrder WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        NSMutableArray *ary0 = [NSMutableArray arrayWithCapacity:20];
        for(NSDictionary *dic in [[resultDic objectForKey:@"Result"] objectForKey:@"ListCurrentOrder"]){
            NSError *error;
            CurrentReservationItem *item = [CurrentReservationItem objectWithKeyValues:dic error:&error];
            if(!error){
                [ary0 addObject:item];
            }
        }
        
        NSMutableArray *ary1 = [NSMutableArray arrayWithCapacity:20];
        for(NSDictionary *dic in [[resultDic objectForKey:@"Result"] objectForKey:@"ListOrderRecord"]){
            NSError *error;
            EndReservationItem *item = [EndReservationItem objectWithKeyValues:dic error:&error];
            if(!error){
                [ary1 addObject:item];
            }
        }
//        if(ary0.count){
            [self.dataAry addObject:ary0];
//        }
//        if(ary1.count){
            [self.dataAry addObject:ary1];
//        }
        if(!self.dataAry.count){
            [Utils showMessage:@"noRevervationHistoryData"];
        }
        
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerId"];
    if(!v){
        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 20)];
        v.backgroundColor = MAIN_VIEW_COLOR;
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 20)];
        lb.textColor = UIColorFromRGB(102, 102, 102);
        lb.font = [UIFont systemFontOfSize:15];
        lb.tag = 10;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(13, 7, 5, 5)];
        iv.image = [UIImage imageNamed:@"list_correct"];
        
        [v addSubview:lb];
        [v addSubview:iv];
    }
    
    if(section == 0){
        UILabel *lb = (UILabel *)[v viewWithTag:10];
        lb.text = @"当前预约";
    }
    else{
        UILabel *lb = (UILabel *)[v viewWithTag:10];
        lb.text = @"预约记录";
    }
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *ary = self.dataAry[section];
    if(ary.count){
        return 20;
    }
    else{
        return 0;
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataAry[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 135;
    }
    else{
        EndReservationItem *item = self.dataAry[indexPath.section][indexPath.row];
        
        if([item.OrderType rangeOfString:@"ks"].length || [item.OrderType rangeOfString:@"fc"].length){
            return 74;
        }else{
            return 134;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        CurrentReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid0"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.actionBtn.tag = indexPath.row;
        [cell.actionBtn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        CurrentReservationItem *item = self.dataAry[indexPath.section][indexPath.row];
        
        NSArray *ary = self.dataAry[0];
        if(ary.count){
            cell.typeLb.text = item.OrderTypeName;
            cell.timeLb.text = item.OrderDate;
            cell.statusLb.text = item.OrderState;
        }
        else{
            cell.typeLb.text = item.ReOrderType;
            cell.timeLb.text = item.ReOrderDdate;
            cell.statusLb.text = item.ReOrderState;
        }
//        if([@"计时班" isEqualToString:[UserInfo shareUserInfo].xxlx]){
//            cell.typeLb.text = item.OrderTypeName;
//            cell.timeLb.text = item.OrderDate;
//            cell.statusLb.text = item.OrderState;
//        }
//        else{
//            cell.typeLb.text = item.ReOrderType;
//            cell.timeLb.text = item.ReOrderDdate;
//            cell.statusLb.text = item.ReOrderState;
//        }
        
        return cell;
    }
    else{
        EndReservationItem *item = self.dataAry[indexPath.section][indexPath.row];
        
        EndReservationCell *cell = nil;
        if([item.OrderType rangeOfString:@"ks"].length || [item.OrderType rangeOfString:@"fc"].length){
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.actionBtn.tag = indexPath.row;
        cell.evaluationBtn.tag = indexPath.row;
        [cell.actionBtn addTarget:self action:@selector(retrunMoenyClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.evaluationBtn addTarget:self action:@selector(evaluationClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.typeLb.text = item.ReOrderType;
        cell.timeLb.text = item.ReOrderDdate;
        cell.statusLb.text = item.ReOrderState;
        cell.jlxmLb.text = item.jlxm;
        cell.jldhLb.text = item.jldh;
        cell.jlchLb.text = item.jlch;
        
        if([@"2" isEqualToString:item.TranState]){
            cell.evaluationBtn.hidden = NO;
            cell.statusDescLb.hidden = YES;
        }
        else{
            cell.evaluationBtn.hidden = YES;
            cell.statusDescLb.hidden = NO;
            cell.statusDescLb.text = [self getTransteSring:item.TranState];
        }
        
        if(item.CanTF){
            cell.actionBtn.hidden = NO;
        }
        else{
            cell.actionBtn.hidden = YES;
        }
        return cell;
    }
}

-(NSString *)getTransteSring:(NSString *)code{
//    2已完成未评价  3已评价 4 不允许评价 5退费中 6 退费审核不通过 7退费审核通过
    if([@"2" isEqualToString:code]){
        return @"已完成未评价";
    }
    else if([@"3" isEqualToString:code]){
        return @"已评价";
    }else if([@"4" isEqualToString:code]){
        return @"不允许评价";
    }else if([@"5" isEqualToString:code]){
        return @"退费中";
    }else if([@"6" isEqualToString:code]){
        return @"退费审核不通过";
    }else if([@"7" isEqualToString:code]){
        return @"退费审核通过";
    }else{
        return @"";
    }
}

//弹出退费输入框action
-(void)retrunMoenyClick:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.returnMoneyActionView];
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.view bringSubviewToFront:self.returnMoneyActionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.returnMoneyActionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.returnMoneyActionView.frame = r;
    } completion:^(BOOL finished) {
        
    }];
    
    self.selectedEndReservationItem = self.dataAry[1][sender.tag];
}

//隐藏退费输入框action
-(void)actionClick:(NSInteger)tag{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.returnMoneyActionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height;
        
        self.returnMoneyActionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.returnMoneyActionView removeFromSuperview];
        /*
        if(tag == 1){
            [self rebackConfirmClick:nil];
        }
         */
    }];
}

//弹出评价action
-(void)evaluationClick:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.evaluationActionView];
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.view bringSubviewToFront:self.evaluationActionView];
    [self.evaluationActionView defaultSetting];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.evaluationActionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.evaluationActionView.frame = r;
    } completion:^(BOOL finished) {
        
    }];
    
    self.selectedEndReservationItem = self.dataAry[1][sender.tag];
}

//隐藏评价action
-(IBAction)evaluationHideClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.evaluationActionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height;
        
        self.evaluationActionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.evaluationActionView removeFromSuperview];
    }];
}

//提交评价
-(void)commitEvaluation:(int)score{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               self.selectedEndReservationItem.SqlId,@"orid",
                               NSStringFromInt(self.evaluationActionView.star0*20),@"appscore",
                               @"4",@"aptype",
                               @"",@"apcont",
                               self.evaluationActionView.apgString,@"apgrade",
                               @"",@"jdg",
                               @"",@"txxyqdg",
                               @"",@"sfg",
                               @"",@"zxg",
                               @"",@"zpgang", nil];
//    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [UserInfo shareUserInfo].uId,@"uid",
//                               self.selectedEndReservationItem.SqlId,@"orid",
//                               NSStringFromInt(score*20),@"appscore",
//                               self.selectedEndReservationItem.TranState,@"aptype",
//                               @"",@"apcont", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AppraiseAdd WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
//        self.endAppearanceTransition.AppStars = NSStringFromInt(score*20);
        
//        [self.tableview reloadData];
        [self requestData];
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

//查看详情
-(void)gotoDetail:(UIButton *)sender{
    self.selectedCurrentReservationItem = self.dataAry[0][sender.tag];
    if([self.selectedCurrentReservationItem.OrderType rangeOfString:@"px"].length){
        TimerReservationDetailController *normalReservationDetailController = [[TimerReservationDetailController alloc] init];
        normalReservationDetailController.currentReservationItem = self.selectedCurrentReservationItem;
        [self.navigationController pushViewController:normalReservationDetailController animated:YES];
    }
    else{
        NormalReservationDetailController *normalReservationDetailController = [[NormalReservationDetailController alloc] init];
        normalReservationDetailController.currentReservationItem = self.selectedCurrentReservationItem;
        [self.navigationController pushViewController:normalReservationDetailController animated:YES];
    }
    
}

- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    CGFloat t = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:t];
    CGRect r = self.returnMoneyActionView.frame;
    r.origin.y =  y-self.returnMoneyActionView.frame.size.height;
    self.returnMoneyActionView.frame = r;
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notif{

    CGFloat t = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:t];
    CGRect r = self.returnMoneyActionView.frame;
    r.origin.y =  self.tabBarController.view.frame.size.height-self.returnMoneyActionView.frame.size.height;
    self.returnMoneyActionView.frame = r;
    
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
                               self.selectedEndReservationItem.SqlId,@"tkyuyueId",
                               self.returnMoneyActionView.inputTv.text,@"readMsgId", nil];
    
    if(self.returnRequest) [self.returnRequest clearDelegatesAndCancel];
    self.returnRequest = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.returnRequest requestGetWithAction:Action_JsbTfSq WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"returnMoneySuccess"];
        [self requestData];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
        _returnMoneyActionView.inputTv.text = @"";
        
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
