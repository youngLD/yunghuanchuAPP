//
//  MyConsumptionListController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "MyConsumptionListController.h"
#import "MJExtension.h"
#import "MyConsumptionCell.h"

@interface MyConsumptionListController ()

@end

@implementation MyConsumptionListController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的消费";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    [self initView];
    [self requestData];
}

-(void)initView{
    self.nib = [UINib nibWithNibName:@"MyConsumptionCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid0"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
}

-(IBAction)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"stuId",nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_StuCharge WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"lisCharge"]){
            NSError *error;
            ChargeItem *item = [ChargeItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        [self.tableview reloadData];
        self.leftMoneyLb.text = [NSString stringWithFormat:@"￥%@",[resultDic objectForKey:@"leftMoney"]];
        
        
        
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataAry  count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        MyConsumptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid0"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = MAIN_VIEW_COLOR;
    ChargeItem *item = self.dataAry[indexPath.row];
    cell.timeLb.text = item.ptime;
    cell.typeLb.text = item.pType;
    cell.moneyLb.text = [NSString stringWithFormat:@"%@元",item.pMoney];
    if([item.pMoney hasPrefix:@"+"]){
        cell.moneyLb.textColor = UIColorFromRGB(28, 234, 3);
    }
    else{
        cell.moneyLb.textColor = UIColorFromRGB(255, 131, 9);
    }
    
    
        
        return cell;
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
