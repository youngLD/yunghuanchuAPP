//
//  ExamRecordListController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/28.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ExamRecordListController.h"
#import "ExamRecordCell.h"
#import "ExamRecordDao.h"
#import "UIAlertView+XY.h"
@interface ExamRecordListController ()

@end

@implementation ExamRecordListController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"考试记录";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    
    ExamRecordDao *dao = [[ExamRecordDao alloc] init];
    [dao openDataBase];
    self.dataAry = [dao selectExamRecors];
    [dao closeDataBase];
    
    if(self.dataAry.count>0){
        self.navigationItem.rightBarButtonItems = [self getNewRightItem];
    }
    
    [self initView];
    
    
}

-(void)initView{
    
    self.nib = [UINib nibWithNibName:@"ExamRecordCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [Utils setExtraCellLineHidden:self.tableview];
    
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExamRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ExamRecordModel *item = self.dataAry[indexPath.row];
    cell.indexLb.text = NSStringFromInt(indexPath.row+1);
    cell.scoreLb.text = [NSString stringWithFormat:@"%@分",item.score];
    cell.timeLb.text = [NSString stringWithFormat:@"用时%@",item.time];
    cell.dateLb.text = item.date;
    cell.headPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"table_%ld",(long)indexPath.row%7]];
    if(item.score.floatValue >= 60){
        cell.resultPic.image = [UIImage imageNamed:@"exam_success"];
    }
    else{
        cell.resultPic.image = [UIImage imageNamed:@"exam_faild"];
    }
    
    return cell;
}

-(void)deleAll:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定清空吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
        if(btnIndex == 1){
            ExamRecordDao *dao = [[ExamRecordDao alloc] init];
            [dao openDataBase];
            [dao deleteExamRecords];
            [dao closeDataBase];
            
            [Utils showMessage:@"清除成功"];
            
            ExamRecordDao *dao2 = [[ExamRecordDao alloc] init];
            [dao2 openDataBase];
            self.dataAry = [dao2 selectExamRecors];
            [dao closeDataBase];
            
            [self.tableview reloadData];
        }
    }];
    
    

}

-(NSArray *)getNewRightItem{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(deleAll:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitle:@"清空" forState:UIControlStateNormal];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;

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
