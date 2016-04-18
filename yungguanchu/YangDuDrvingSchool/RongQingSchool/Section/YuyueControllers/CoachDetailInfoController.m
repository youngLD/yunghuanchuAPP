//
//  CoachDetailInfoController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "CoachDetailInfoController.h"
#import "CoachCell.h"
#import "PayForTimerReservationController.h"

#import "MJExtension.h"

@interface CoachDetailInfoController (){
    
}

@end

@implementation CoachDetailInfoController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教练信息";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    
    [self requestData];
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.nib = [UINib nibWithNibName:@"CoachCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.selectSoltListItems = [NSMutableArray arrayWithCapacity:20];
    
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentid",
                               self.timerReservationItem.ordate,@"ordate",
                               self.timerReservationItem.nowDate,@"nowdate",
                               self.timerReservationItem.Jlid,@"Jlid",nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_SelTraining WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        NSDictionary *jlxxDic = [[resultDic objectForKey:@"Result"] objectForKey:@"Jlxx"];
        self.dataDic = jlxxDic;
        self.nameLb.text = [jlxxDic objectForKey:@"Jlxm"];
        self.genderLb.text = [jlxxDic objectForKey:@"Jlxb"];
        self.jiaolingLb.text = [NSString stringWithFormat:@"教龄: %@",[jlxxDic objectForKey:@"Jl"]];
        self.moenyLb.text = [NSString stringWithFormat:@"%@/学时",[jlxxDic objectForKey:@"OrderPrice"]];
        self.callLb.text = [NSString stringWithFormat:@"电话: %@",[jlxxDic objectForKey:@"Jldh"]];
        self.groupLb.text = [NSString stringWithFormat:@"%@",[jlxxDic objectForKey:@"Jlsszd"]];
        self.orderShengyuNum = [[jlxxDic objectForKey:@"OrderShengyuNum"] intValue];
        
        for(UIImageView *starPic in self.starView.subviews){
            if(starPic.tag<= [[jlxxDic objectForKey:@"CoachStars"] intValue]){
                starPic.image = [UIImage imageNamed:@"star_full"];
            }
            else{
                starPic.image = [UIImage imageNamed:@"star_blank"];
            }
        }
        
        self.dataAry = [NSMutableArray arrayWithCapacity:20];
        NSArray *list = [[resultDic objectForKey:@"Result"] objectForKey:@"List"];
        for(NSDictionary *dic in list){
            CoachDetailItem *item = [[CoachDetailItem alloc] init];
            item.Orderdate = [dic objectForKey:@"Orderdate"];
            item.Soltlist = [NSMutableArray arrayWithCapacity:20];
            for(NSDictionary *dic2 in [dic objectForKey:@"Soltlist"]){
                NSError *error;
                SoltlistItem *soltlistItem = [SoltlistItem objectWithKeyValues:dic2 error:&error];
                if(!error){
                    [item.Soltlist addObject:soltlistItem];
                }
                
            }
            
            [self.dataAry addObject:item];
        }
        
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}


-(IBAction)gotoPay:(id)sender{
    if(!self.selectSoltListItems.count){
        [Utils showMessage:@"SoltlistItemMinOne"];
        return;
    }
    CGFloat totalMoney = 0;
    NSString *stringArgs = @"";
    int j = 0;
    for(CoachDetailItem *coachDetailItem in self.dataAry){
        for(SoltlistItem *soltListItem in coachDetailItem.Soltlist){
            for(SoltlistItem *selectedSoltListItem in self.selectSoltListItems){
                
                if(selectedSoltListItem == soltListItem){
                    if(j == self.selectSoltListItems.count-1){
                        NSString *soltString = [NSString stringWithFormat:@"%@,%@",coachDetailItem.Orderdate,selectedSoltListItem.Timesoltid];
                        stringArgs = [NSString stringWithFormat:@"%@%@",stringArgs,soltString];
                    }
                    else{
                        NSString *soltString = [NSString stringWithFormat:@"%@,%@|",coachDetailItem.Orderdate,selectedSoltListItem.Timesoltid];
                        stringArgs = [NSString stringWithFormat:@"%@%@",stringArgs,soltString];
                    }
                    j++;
                    totalMoney += selectedSoltListItem.Price.floatValue;
                }
                
            }
        }
    }
    
    if(totalMoney > [UserInfo shareUserInfo].leftMoney.floatValue){
        [Utils showMessage:@"haveNoMoreMoney"];
        return;
    }
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"studentId",
                               self.timerReservationItem.Jlid,@"jlid",
                               stringArgs,@"stringargs",nil];
    
    
    PayForTimerReservationController *payForTimerYuyueController = [[PayForTimerReservationController alloc] init];
    payForTimerYuyueController.postParam = postParam;
    payForTimerYuyueController.selectSoltListItems = self.selectSoltListItems;
    payForTimerYuyueController.totalMoney = [NSString stringWithFormat:@"￥%.2f",totalMoney];
    payForTimerYuyueController.coachName = [self.dataDic objectForKey:@"Jlxm"];
    [self.navigationController pushViewController:payForTimerYuyueController animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoachDetailItem *item = self.dataAry[indexPath.row];
    if(item.Soltlist.count){
        return item.Soltlist.count * 45 + 15;
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    cell.contentView.clipsToBounds = YES;
    
    CoachDetailItem *item = self.dataAry[indexPath.row];
    cell.dayTimeLb.text = item.Orderdate;
    for(int i=0; i<item.Soltlist.count; i++){
        SoltlistItem *soltlistItem = item.Soltlist[i];
        soltlistItem.Orderdate = item.Orderdate;
        UILabel *hourTimeLb = cell.hourTimeAry[i];
        UILabel *hourMarkLb = cell.hourMarkAry[i];
        UIButton *hourBtn = cell.hourTimeBtnAry[i];
        UILabel *priceLb = cell.priceAry[i];
        
        [hourBtn.layer setValue:@(indexPath.row) forKey:@"row"];
        [hourBtn.layer setValue:@(i) forKey:@"index"];
        [hourBtn addTarget:self action:@selector(selecteTime:) forControlEvents:UIControlEventTouchUpInside];
        
        hourTimeLb.text = soltlistItem.Timesolt;
        priceLb.text = [NSString stringWithFormat:@"￥%@",soltlistItem.Price];
        [self getTimeSoltState:soltlistItem.TimeSoltState markLb:hourMarkLb actionBtn:hourBtn];
        if(soltlistItem.isSelected){
            [hourBtn setBackgroundImage:[UIImage imageNamed:@"rb_ss"] forState:UIControlStateNormal];
        }
    }
    
    return cell;
}

-(void)getTimeSoltState:(NSString *)state markLb:(UILabel *)markLb actionBtn:(UIButton *)actionBtn{
    //时间段状态 0可预约 1已预约 2已请假
    if([@"0" isEqualToString:state]){
        markLb.text = @"可预约";
        markLb.textColor = UIColorFromRGB(3, 180, 248);
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"rb_sn"] forState:UIControlStateNormal];
        actionBtn.userInteractionEnabled = YES;
    }
    else if([@"1" isEqualToString:state]){
        markLb.text = @"已预约";
        markLb.textColor = UIColorFromRGB(102, 102, 102);
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"bg_area_white9"] forState:UIControlStateNormal];
        actionBtn.userInteractionEnabled = NO;
    }
    else{
        markLb.text = @"已请假";
        markLb.textColor = UIColorFromRGB(102, 102, 102);
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"bg_area_white9"] forState:UIControlStateNormal];
        actionBtn.userInteractionEnabled = NO;
    }
}

-(void)selecteTime:(UIButton *)sender{
    int row = [[sender.layer valueForKey:@"row"] intValue];
    int index = [[sender.layer valueForKey:@"index"] intValue];
    
    CoachDetailItem *tmpCoachDetailItem = self.dataAry[row];
    SoltlistItem *selectingSoltlistItem = tmpCoachDetailItem.Soltlist[index];
    
    BOOL haveSame = NO;
    for(SoltlistItem *selectedSoltListItem in self.selectSoltListItems){
        if(selectingSoltlistItem == selectedSoltListItem){
            haveSame = YES;
            break;
        }
    }
    if(haveSame){
        CoachDetailItem *tmpCoachDetailItem = self.dataAry[row];
        SoltlistItem *selectedSoltlistItem = tmpCoachDetailItem.Soltlist[index];
        selectedSoltlistItem.isSelected = NO;
        [self.selectSoltListItems removeObject:selectedSoltlistItem];
    }
    else{
        if(self.selectSoltListItems.count < self.orderShengyuNum){
            CoachDetailItem *tmpCoachDetailItem = self.dataAry[row];
            SoltlistItem *selectedSoltlistItem = tmpCoachDetailItem.Soltlist[index];
            selectedSoltlistItem.isSelected = YES;
            [self.selectSoltListItems addObject:selectedSoltlistItem];
        }
        else{
            [Utils showMessage:[NSString stringWithFormat:@"最多允许选择%d个时间段",self.orderShengyuNum]];
        }
    }
    
    [self.tableview reloadData];
}

-(IBAction)call:(id)ctrl{
    NSString *s = [NSString stringWithFormat:@"tel://%@",[self.dataDic objectForKey:@"Jldh"]];
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
