//
//  ReservationEvaluateController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ReservationEvaluateListController.h"
#import "ReservationEvaluateCell.h"
#import "TabBarViewController.h"
#import "MJExtension.h"

@interface ReservationEvaluateListController ()

@end

@implementation ReservationEvaluateListController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务评价";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    [self requestData];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.nib = [UINib nibWithNibName:@"ReservationEvaluateCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    //五组星星的action
    self.evaluationActionView5 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationAction5 class]) owner:self options:nil] lastObject];
    self.evaluationActionView5.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.evaluationActionView5.frame.size.height);
    
    __weak typeof(self) weakSelf = self;
    [self.evaluationActionView5 addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick:nil];
        }
        else{
            if(weakSelf.evaluationActionView5.star0<1){
                [Utils showMessage:@"收费岗评价不能为空"];
            }
            else if(weakSelf.evaluationActionView5.star1<1){
                [Utils showMessage:@"建档岗评价不能为空"];
            }
            else if(weakSelf.evaluationActionView5.star2<1){
                [Utils showMessage:@"签订岗评价不能为空"];
            }
            else if(weakSelf.evaluationActionView5.star3<1){
                [Utils showMessage:@"照相岗评价不能为空"];
            }
            else if(weakSelf.evaluationActionView5.star4<1){
                [Utils showMessage:@"抓拍岗评价不能为空"];
            }
            else{
                [weakSelf actionClick:nil];
                
                NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UserInfo shareUserInfo].uId,@"uid",
                                           weakSelf.selectedReservationEvaluationItem.TranOrderId,@"orid",
                                           @"",@"appscore",
                                           weakSelf.selectedReservationEvaluationItem.AppTypeNum,@"aptype",
                                           @"",@"apcont",
                                           @"",@"apgrade",
                                           NSStringFromInt(weakSelf.evaluationActionView5.star0*20),@"sfg",
                                           NSStringFromInt(weakSelf.evaluationActionView5.star1*20),@"jdg",
                                           NSStringFromInt(weakSelf.evaluationActionView5.star2*20),@"txxyqdg",
                                           NSStringFromInt(weakSelf.evaluationActionView5.star3*20),@"zxg",
                                           NSStringFromInt(weakSelf.evaluationActionView5.star4*20),@"zpgang", nil];
                
                [weakSelf commitEvaluation:postParam];
            }
            
        }
    }];
    
    
    //三组星星的action
    self.evaluationActionView3 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationAction3 class]) owner:self options:nil] lastObject];
    self.evaluationActionView3.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.evaluationActionView3.frame.size.height);
    [self.evaluationActionView3 addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick:nil];
        }
        else{
            if(weakSelf.evaluationActionView3.star0<1){
                [Utils showMessage:@"服务态度评价不能为空"];
            }
            else if(weakSelf.evaluationActionView3.star1<1){
                [Utils showMessage:@"教学水平评价不能为空"];
            }
            else if(weakSelf.evaluationActionView3.star2<1){
                [Utils showMessage:@"综合水平评价不能为空"];
            }
            else{
                [weakSelf actionClick:nil];
                
                NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UserInfo shareUserInfo].uId,@"uid",
                                           weakSelf.selectedReservationEvaluationItem.TranOrderId,@"orid",
                                           @"",@"appscore",
                                           weakSelf.selectedReservationEvaluationItem.AppTypeNum,@"aptype",
                                           @"",@"apcont",
                                           weakSelf.evaluationActionView3.apgString,@"apgrade",
                                           NSStringFromInt(weakSelf.evaluationActionView3.star0*20),@"jdg",
                                           NSStringFromInt(weakSelf.evaluationActionView3.star1*20),@"txxyqdg",
                                           NSStringFromInt(weakSelf.evaluationActionView3.star2*20),@"sfg",
                                           @"",@"zxg",
                                           weakSelf.selectedReservationEvaluationItem.km23Jly,@"zpgang", nil];
                
                [weakSelf commitEvaluation:postParam];
            }
            
        }
    }];
    
    //一组星星的action
    self.evaluationActionView1 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationAction1 class]) owner:self options:nil] lastObject];
    self.evaluationActionView1.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, self.evaluationActionView1.frame.size.height);
    [self.evaluationActionView1 addClickBlock:^(NSInteger index) {
        if(index == 0){
            [weakSelf actionClick:nil];
        }
        else{
            if(weakSelf.evaluationActionView1.star0<1){
                [Utils showMessage:@"评价不能为空"];
            }
            else{
                [weakSelf actionClick:nil];
                
                NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UserInfo shareUserInfo].uId,@"uid",
                                           weakSelf.selectedReservationEvaluationItem.TranOrderId,@"orid",
                                           NSStringFromInt(weakSelf.evaluationActionView1.star0*20),@"appscore",
                                           weakSelf.selectedReservationEvaluationItem.AppTypeNum,@"aptype",
                                           @"",@"apcont",
                                           weakSelf.evaluationActionView1.apgString,@"apgrade",
                                           @"",@"jdg",
                                           @"",@"txxyqdg",
                                           @"",@"sfg",
                                           @"",@"zxg",
                                           weakSelf.selectedReservationEvaluationItem.km23Jly,@"zpgang", nil];
                
                [weakSelf commitEvaluation:postParam];
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
    [self.request requestGetWithAction:Action_DispAppraise WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic in [resultDic objectForKey:@"Result"]){
            NSError *error;
            ReservationEvaluateItem *item = [ReservationEvaluateItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
        
        if(!self.dataAry.count){
            [Utils showMessage:@"noRevervationEvaluationData"];
        }
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReservationEvaluateItem *item = self.dataAry[indexPath.row];
    //预约培训评价
    if([@"4" isEqualToString:item.AppTypeNum]){
        //高度虽然相同，但是内容不一样，一个显示评价按钮，一个显示评价描述（好坏差）
        if([@"1" isEqualToString:item.ApprState]){
            return 150+45;//
        }
        else{
            return 150+45;
        }
        
    }
    //服务大厅评价（只有服务大厅评价没有好坏差评价描述）
    else if([@"1" isEqualToString:item.AppTypeNum]){
        
        if([@"1" isEqualToString:item.ApprState]){
            return 150 + 45*4;
        }
        else{
            return 150 + 45*4 +45;
        }
    }
    //科目二评价
    else if([@"2" isEqualToString:item.AppTypeNum]){
        
        //高度虽然相同，但是内容不一样，一个显示评价按钮，一个显示评价描述（好坏差）
        if([@"1" isEqualToString:item.ApprState]){
            return 150 +45 + 45*2;
        }
        else{
            return 150 + 45*2 +45;
        }
    }
    //科目三评价
    else if([@"3" isEqualToString:item.AppTypeNum]){
        
        //高度虽然相同，但是内容不一样，一个显示评价按钮，一个显示评价描述（好坏差）
        if([@"1" isEqualToString:item.ApprState]){
            return 150 +45 + 45*2;
        }
        else{
            return 150 + 45*2 +45;
        }
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReservationEvaluateItem *item = self.dataAry[indexPath.row];
    ReservationEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.evaluationBtn.tag = indexPath.row;
    [cell.evaluationBtn addTarget:self action:@selector(evaluationClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if([@"1" isEqualToString:item.ApprState]){
        cell.evaluationBgView.hidden = YES;
    }
    else{
        cell.evaluationBgView.hidden = NO;
    }
    
    cell.typeLb.text = item.AppraiseType;
    cell.timeLb.text = item.AppTime;
    cell.evaluationDesLb.text = item.appgrade;
    
    //预约培训评价
    if([@"4" isEqualToString:item.AppTypeNum]){
        
        [self setStart:cell.starView score:item.AppStars typeName:@"" setFrame:CGRectMake(100, cell.starView.frame.origin.y, cell.starView.frame.size.width, cell.starView.frame.size.height)];
        
//        //评价星级lb
//        CGRect r = cell.starTitleLb.frame;
//        r.origin.y = 90;
//        r.size.height = 45;
//        cell.starTitleLb.frame = r;
        
        if([@"1" isEqualToString:item.ApprState]){
            //显示评价描述lb(evaluationDesLb)
            CGRect r = cell.allStarBgView.frame;
            r.origin.y = 135;
            r.size.height = 45;
            cell.allStarBgView.frame = r;
        }
        else{
            //不显示评价描述lb(evaluationDesLb)
            CGRect r = cell.allStarBgView.frame;
            r.origin.y = 90;
            r.size.height = 45;
            cell.allStarBgView.frame = r;
        }
        
        return cell;
    }
    //服务大厅评价
    else if([@"1" isEqualToString:item.AppTypeNum]){
        
        cell.starView.hidden = NO;
        cell.stateLb.hidden = NO;
        
        //收费岗
        [self setStart:cell.starView score:item.sfg typeName:@"收费岗" setFrame:CGRectMake(160, cell.starView.frame.origin.y, cell.starView.frame.size.width, cell.starView.frame.size.height)];
        
        //建档岗
        [self setStart:cell.starView1 score:item.jdg typeName:@"建档岗" setFrame:CGRectMake(160, cell.starView1.frame.origin.y, cell.starView1.frame.size.width, cell.starView1.frame.size.height)];
        
        //签订岗
        [self setStart:cell.starView2 score:item.txxyqdg typeName:@"签订岗" setFrame:CGRectMake(160, cell.starView2.frame.origin.y, cell.starView2.frame.size.width, cell.starView2.frame.size.height)];
        
        //照相岗
        [self setStart:cell.starView3 score:item.zxg typeName:@"照相岗" setFrame:CGRectMake(160, cell.starView3.frame.origin.y, cell.starView3.frame.size.width, cell.starView3.frame.size.height)];
        
        //抓拍岗
        [self setStart:cell.starView4 score:item.zpgang typeName:@"抓拍岗" setFrame:CGRectMake(160, cell.starView4.frame.origin.y, cell.starView4.frame.size.width, cell.starView4.frame.size.height)];
        
        //评价星级
//        CGRect r = cell.starTitleLb.frame;
//        r.origin.y = 90;
//        r.size.height = 45*5;
//        cell.starTitleLb.frame = r;
        
        //不显示评价描述lb(evaluationDesLb)
        CGRect r = cell.allStarBgView.frame;
        r.origin.y = 90;
        r.size.height = 45*5;
        cell.allStarBgView.frame = r;
        
        return cell;
    }
    //科目二/三评价
    else if([@"2" isEqualToString:item.AppTypeNum] || [@"3" isEqualToString:item.AppTypeNum]){
        
        //服务态度
        [self setStart:cell.starView score:item.jdg typeName:@"服务态度" setFrame:CGRectMake(170, cell.starView.frame.origin.y, cell.starView.frame.size.width, cell.starView.frame.size.height)];
        
        //教学水平
        [self setStart:cell.starView1 score:item.txxyqdg typeName:@"教学水平" setFrame:CGRectMake(170, cell.starView1.frame.origin.y, cell.starView1.frame.size.width, cell.starView1.frame.size.height)];
        
        //综合水平
        [self setStart:cell.starView2 score:item.sfg typeName:@"综合水平" setFrame:CGRectMake(170, cell.starView2.frame.origin.y, cell.starView2.frame.size.width, cell.starView2.frame.size.height)];
        
        //评价星级
//        CGRect r = cell.starTitleLb.frame;
//        r.origin.y = 90;
//        r.size.height = 45*3;
//        cell.starTitleLb.frame = r;
        
        if([@"1" isEqualToString:item.ApprState]){
            //显示评价描述lb(evaluationDesLb)
            CGRect r = cell.allStarBgView.frame;
            r.origin.y = 135;
            r.size.height = 45*3;
            cell.allStarBgView.frame = r;
        }
        else{
            //不显示评价描述lb(evaluationDesLb)
            CGRect r = cell.allStarBgView.frame;
            r.origin.y = 90;
            r.size.height = 45*3;
            cell.allStarBgView.frame = r;
        }
        
        return cell;
    }
    else{
        return cell;
    }
}

-(void)setStart:(UIView *)starView score:(NSString *)score typeName:(NSString *)name setFrame:(CGRect)frame{
    if(![Utils isNullOrEmpty:score] && score.intValue){
        for(UIImageView *starPic in starView.subviews){
            if(starPic.tag<= score.intValue/20){
                starPic.image = [UIImage imageNamed:@"star_full"];
            }
            else{
                starPic.image = [UIImage imageNamed:@"star_blank"];
            }
        }
    }
    else{
        for(UIImageView *starPic in starView.subviews){
            starPic.image = [UIImage imageNamed:@"star_blank"];
        }
    }
    
    starView.frame = frame;
    
    //名字
    UIView *superView = starView.superview;
    UILabel *stateLb = (UILabel *)[superView viewWithTag:100];
    stateLb.text = name;
}

//显示评价action
-(void)evaluationClick:(UIButton *)sender{
    
    ReservationEvaluateItem *item = self.dataAry[sender.tag];
    //预约培训评价
    if([@"4" isEqualToString:item.AppTypeNum]){
        TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
        [self.tabBarController.view addSubview:self.evaluationActionView1];
        tabbarVc.grayBtn.hidden = NO;
        [tabbarVc.view bringSubviewToFront:self.evaluationActionView1];
        [self.evaluationActionView1 defaultSetting];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = self.evaluationActionView1.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            self.evaluationActionView1.frame = r;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    //服务大厅评价
    else if([@"1" isEqualToString:item.AppTypeNum]){
        TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
        [self.tabBarController.view addSubview:self.evaluationActionView5];
        tabbarVc.grayBtn.hidden = NO;
        [tabbarVc.view bringSubviewToFront:self.evaluationActionView5];
        [self.evaluationActionView5 defaultSetting];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = self.evaluationActionView5.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            self.evaluationActionView5.frame = r;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    //科目二/三评价
    else if([@"2" isEqualToString:item.AppTypeNum] || [@"3" isEqualToString:item.AppTypeNum]){
        TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
        [self.tabBarController.view addSubview:self.evaluationActionView3];
        tabbarVc.grayBtn.hidden = NO;
        [tabbarVc.view bringSubviewToFront:self.evaluationActionView3];
        [self.evaluationActionView3 defaultSetting];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect r = self.evaluationActionView3.frame;
            r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
            
            self.evaluationActionView3.frame = r;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
    }
    
    self.selectedReservationEvaluationItem = self.dataAry[sender.tag];
}

//隐藏评价action
-(IBAction)actionClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.evaluationActionView5.frame;
        r.origin.y = tabbarVc.view.frame.size.height;
        self.evaluationActionView5.frame = r;
        
        CGRect r2 = self.evaluationActionView3.frame;
        r2.origin.y = tabbarVc.view.frame.size.height;
        self.evaluationActionView3.frame = r2;
        
        CGRect r3 = self.evaluationActionView1.frame;
        r3.origin.y = tabbarVc.view.frame.size.height;
        self.evaluationActionView1.frame = r3;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.evaluationActionView5 removeFromSuperview];
        [self.evaluationActionView3 removeFromSuperview];
        [self.evaluationActionView1 removeFromSuperview];
    }];
}

-(void)commitEvaluation:(NSDictionary *)postParam{
//    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [UserInfo shareUserInfo].uId,@"uid",
//                               self.selectedReservationEvaluationItem.TranOrderId,@"orid",
//                               NSStringFromInt(score*20),@"appscore",
//                               self.selectedReservationEvaluationItem.AppTypeNum,@"aptype",
//                               @"",@"apcont", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AppraiseAdd WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
//        self.selectedReservationEvaluationItem.AppStars = NSStringFromInt(score*20);
//        
//        [self.tableview reloadData];
        [self requestData];
        [Utils removeProgressHUB:self.view];
        
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
