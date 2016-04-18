//
//  NormalYuyueListController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "NormalReservationListController.h"
#import "ReservationCell.h"
#import "TabBarViewController.h"
#import "ActionView.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface NormalReservationListController (){
    ActionView *actionView;
}

@end

@implementation NormalReservationListController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择教练";
    self.navigationItem.leftBarButtonItems = [self.navigationController getSmallBackButtons];
    
    [self initView];
    
    [self requestData];
}

-(void)initView{
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"underline_55"] forState:UIControlStateSelected];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.btn1.selected = YES;
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"underline_55"] forState:UIControlStateSelected];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    self.nib = [UINib nibWithNibName:@"ReservationCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
    
    //底部菜单
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
                               [UserInfo shareUserInfo].uId,@"studentId",
                               @"",@"strsearch", nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_FenCheJL WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        self.dataAry = [NSMutableArray arrayWithCapacity:20];
        for(NSDictionary *dic in [resultDic objectForKey:@"Result"]){
            NSError *error;
            NormalReservationItem *item = [NormalReservationItem objectWithKeyValues:dic error:&error];
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

-(IBAction)selectMenu1Btn:(UIButton *)sender{
    [self showOrHidePaixuMenu:nil];
}

-(IBAction)selectMenu2Btn:(UIButton *)sender{
    [self showOrHideYuyueMenu:nil];
}

-(IBAction)showOrHidePaixuMenu:(id)sender{
    if(self.btn1.isSelected){
        if(self.menu1IsShow){
            [self hideMenu1:^(BOOL finished) {
                
            }];
        }
        else{
            [self showMenu1];
        }
    }
    else{
        self.btn1.selected = YES;
        self.titleLb1.textColor = UIColorFromRGB(3, 180, 248);
        self.titlePic1.image = [UIImage imageNamed:@"list_arrow_selected"];
        self.titlePic1.transform = CGAffineTransformMakeRotation(M_PI/1000*999.99);
        
        
        self.btn2.selected = NO;
        self.titleLb2.textColor = UIColorFromRGB(102, 102, 102);
        self.titlePic2.image = [UIImage imageNamed:@"list_arrow_gray"];
        self.titlePic2.transform = CGAffineTransformMakeRotation(0);
        [self hideMenu2:^(BOOL finished) {
            [self showMenu1];
        }];
        
    }
}

-(IBAction)showOrHideYuyueMenu:(id)sender{
    if(self.btn2.isSelected){
        if(self.menu2IsShow){
            [self hideMenu2:^(BOOL finished) {
                
            }];
        }
        else{
            [self showMenu2];
        }
    }
    else{
        self.btn2.selected = YES;
        self.titleLb2.textColor = UIColorFromRGB(3, 180, 248);
        self.titlePic2.image = [UIImage imageNamed:@"list_arrow_selected"];
        self.titlePic2.transform = CGAffineTransformMakeRotation(M_PI/1000*999.99);
        
        
        self.btn1.selected = NO;
        self.titleLb1.textColor = UIColorFromRGB(102, 102, 102);
        self.titlePic1.image = [UIImage imageNamed:@"list_arrow_gray"];
        self.titlePic1.transform = CGAffineTransformMakeRotation(0);
        [self hideMenu1:^(BOOL finished) {
            [self showMenu2];
        }];
        
    }
    
}

-(void)hideMenu1:(void (^)(BOOL finished))completion1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect r = self.menuBgView1.frame;
        r.origin.y = CGRectGetMaxY(self.indicatorView.frame)-r.size.height;
        self.menuBgView1.frame = r;
        self.menu1IsShow = NO;
    } completion:^(BOOL finished) {
        self.grayBgControl.hidden = YES;
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        CLog(@"111111");
        completion1(finished);
    }];
}

-(void)showMenu1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.grayBgControl.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.menuBgView1.frame;
        r.origin.y = CGRectGetMaxY(self.indicatorView.frame);
        self.menuBgView1.frame = r;
        self.menu1IsShow = YES;
    } completion:^(BOOL finished) {
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        self.grayBgControl.hidden = NO;
    }];
}

-(void)hideMenu2:(void (^)(BOOL finished))completion1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect r = self.menuBgView2.frame;
        r.origin.y = CGRectGetMaxY(self.indicatorView.frame)-r.size.height;
        self.menuBgView2.frame = r;
        self.menu2IsShow = NO;
    } completion:^(BOOL finished) {
        self.grayBgControl.hidden = YES;
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        completion1(finished);
    }];
}

-(void)showMenu2{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.grayBgControl.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.menuBgView2.frame;
        r.origin.y = CGRectGetMaxY(self.indicatorView.frame);
        self.menuBgView2.frame = r;
        self.menu2IsShow = YES;
    } completion:^(BOOL finished) {
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        self.grayBgControl.hidden = NO;
        CLog(@"222222");
    }];
}

-(IBAction)hideAllMenu:(id)sender{
    [self hideMenu1:^(BOOL finished) {
        
    }];
    [self hideMenu2:^(BOOL finished) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row%2){
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else{
        cell.contentView.backgroundColor = UIColorFromRGB(247, 247, 247);
    }
    
    cell.yuyueBtn.tag = indexPath.row;
    [cell.yuyueBtn addTarget:self action:@selector(actionShow:) forControlEvents:UIControlEventTouchUpInside];
    cell.callCtl.tag = indexPath.row;
    [cell.callCtl addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    
    NormalReservationItem *item = self.dataAry[indexPath.row];
    [cell.headPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",SERVER_IP,item.Jlpic]] placeholderImage:[UIImage imageNamed:@"teacher_header"]];
    cell.nameLb.text = item.Jlxm;
    cell.sexLb.text = item.Jlxb;
    cell.mobileLb.text = item.Jldh;
    cell.groupLb.text = item.Jlsszd;
    
    return cell;
}

-(void)actionShow:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:actionView];
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.view bringSubviewToFront:actionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = actionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        actionView.frame = r;
    } completion:^(BOOL finished) {
        
    }];
    
    self.selectedNoramlReservationItem = self.dataAry[sender.tag];
}

//点击底部菜单按钮
-(void)actionClick:(id)sender{
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

//提交预约
-(void)commit{
    /*
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId",
                               self.selectedNoramlReservationItem.Jlid,@"jlId",
                               self.selectedNoramlReservationItem.Cph,@"cph", nil];
    
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AddCarorTrainbook WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"reservationSuccess"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
     */
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId",
                               self.xid,@"jhid",
                               self.selectedNoramlReservationItem.Jlid,@"Jlid", nil];
    
    if(self.request){
        [self.request clearDelegatesAndCancel];
    }
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_FenCheYY WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"reservationSuccess"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failedBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
    }];
}

-(void)call:(UIControl *)ctrl{
    NormalReservationItem *item = self.dataAry[ctrl.tag];
    NSString *s = [NSString stringWithFormat:@"tel://%@",item.Jldh];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
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
