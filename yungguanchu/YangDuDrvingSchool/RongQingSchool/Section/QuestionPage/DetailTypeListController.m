//
//  DetailTypeListController.m
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "DetailTypeListController.h"
#import "DetailTypeListCell.h"
#import "QuestionListController.h"

@interface DetailTypeListController ()

@end

@implementation DetailTypeListController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    [self initView];
    [self initTitle];
    
    //章节联系
    if(self.type == 6){
        DetailTypeDao *dao = [[DetailTypeDao alloc] init];
        [dao openDataBase];
        if([UserInfo shareUserInfo].KemuTag == 1){
            self.dataAry = [dao selectAllChapter:[UserInfo shareUserInfo].userCarType];
        }
        else{
            self.dataAry = [dao selectAllChapter:KeMu2];
        }
        [dao closeDataBase];
        
        [self.tableview reloadData];
        
    }
    //我的收藏
    else if(self.type == 2){
        DetailTypeDao *dao = [[DetailTypeDao alloc] init];
        [dao openDataBase];
        if([UserInfo shareUserInfo].KemuTag == 1){
            self.dataAry = [dao selectMyCollectionChapter:[UserInfo shareUserInfo].userCarType];
        }
        else{
            self.dataAry = [dao selectMyCollectionChapter:KeMu2];
        }
        [dao closeDataBase];
        
        [self.tableview reloadData];
    }
    //我的错题
    else if(self.type == 3){
        DetailTypeDao *dao = [[DetailTypeDao alloc] init];
        [dao openDataBase];
        if([UserInfo shareUserInfo].KemuTag == 1){
            self.dataAry = [dao selectMyWrongChapter:[UserInfo shareUserInfo].userCarType];
        }
        else{
            self.dataAry = [dao selectMyWrongChapter:KeMu2];
        }
        [dao closeDataBase];
        
        [self.tableview reloadData];
    }
    //未做练习题
    else if(self.type == 7){
        DetailTypeDao *dao = [[DetailTypeDao alloc] init];
        [dao openDataBase];
        if([UserInfo shareUserInfo].KemuTag == 1){
            self.dataAry = [dao selectNeverDoChapter:[UserInfo shareUserInfo].userCarType];
        }
        else{
            self.dataAry = [dao selectNeverDoChapter:KeMu2];
        }
        [dao closeDataBase];
        
        [self.tableview reloadData];
    }
    
}

-(void)initView{
    
    self.nib = [UINib nibWithNibName:@"DetailTypeListCell" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    [Utils setExtraCellLineHidden:self.tableview];
    
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 75;
    }
    else{
        return 45;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLb.text = self.titleAry[indexPath.row];
    cell.countLb.text = self.dataAry[indexPath.row];
    cell.headPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"table_%ld",(long)indexPath.row%7]];
    cell.backgroundColor = MAIN_VIEW_COLOR;
    
    if(indexPath.row == 0 || indexPath.row == 1){
        cell.topLine.hidden = NO;
    }
    else{
        cell.topLine.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataAry[indexPath.row] intValue]){
        QuestionListController *questionListController = [[QuestionListController alloc] init];
        questionListController.type = self.type;
        questionListController.detailType = self.detailTypeAry[indexPath.row];
        questionListController.title = self.title;
        [self.navigationController pushViewController:questionListController animated:YES];
    }
    else{
        [Utils showMessage:@"noQuestion"];
    }
}

/**
 *  章节信息
 1 道路交通安全法
 2 道路交通信号
 3 行车安全、文明驾驶
 4 机动车驾驶操作基础知识
 5 科目四违法的案例分析
 6 科目四安全行车常识
 7 科目四 常见交通标志、标线和交通手势辨识
 8 科目四驾驶职业道德和文明驾驶常识
 9 科目四恶劣天气和复杂道路条件下驾驶常识
 10 科目四紧急情况下避险常识
 11 科目四交通事故救护及常见危化品处置常识
 12 货车专用题
 13 客车专用
 14 摩托车专用
 */
-(void)initTitle{
    if([UserInfo shareUserInfo].KemuTag == 1){
        if([UserInfo shareUserInfo].userCarType == XiaoChe){
            self.titleAry = @[@"全部",
                              @"道路交通安全法律、法规",
                              @"道路交通信号",
                              @"行车安全、文明驾驶",
                              @"机动车驾驶操作基础知识"];
            self.detailTypeAry = @[@"0",
                                   @"1",
                                   @"2",
                                   @"3",
                                   @"4"];
        }
        else if([UserInfo shareUserInfo].userCarType == KeChe){
            self.titleAry = @[@"全部",
                              @"道路交通安全法律、法规",
                              @"道路交通信号",
                              @"行车安全、文明驾驶",
                              @"机动车驾驶操作基础知识",
                              @"客车专用知识"];
            self.detailTypeAry = @[@"0",
                                   @"1",
                                   @"2",
                                   @"3",
                                   @"4",
                                   @"13"];
        }
        else if([UserInfo shareUserInfo].userCarType == HuoChe){
            self.titleAry = @[@"全部",
                              @"道路交通安全法律、法规",
                              @"道路交通信号",
                              @"行车安全、文明驾驶",
                              @"机动车驾驶操作基础知识",
                              @"货车专用知识"];
            self.detailTypeAry = @[@"0",
                                   @"1",
                                   @"2",
                                   @"3",
                                   @"4",
                                   @"12"];
        }
        else if([UserInfo shareUserInfo].userCarType == MoTuoChe){
            self.titleAry = @[@"全部",
                              @"道路交通安全法律、法规",
                              @"道路交通信号",
                              @"行车安全、文明驾驶",
                              @"机动车驾驶操作基础知识",
                              @"摩托车专用知识"];
            self.detailTypeAry = @[@"0",
                                   @"1",
                                   @"2",
                                   @"3",
                                   @"4",
                                   @"14"];
            
        }
        
        
    }
    else if([UserInfo shareUserInfo].KemuTag == 2){
        self.titleAry = @[@"全部",
                          @"违法行为综合判断与案例分析",
                          @"安全行车常识",
                          @"常见交通标志、标线和交通手势辨识",
                          @"驾驶职业道德和文明驾驶常识",
                          @"恶劣天气和复杂道路条件下驾驶常识",
                          @"紧急情况下避险常识",
                          @"交通事故救护及危化品处置尝试"];
        
        self.detailTypeAry = @[@"0",
                               @"5",
                               @"6",
                               @"7",
                               @"8",
                               @"9",
                               @"10",
                               @"11"];
    }
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
