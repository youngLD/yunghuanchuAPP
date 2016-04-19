//
//  YunGuanHomePageViewController.m
//  zhihuaSchool
//
//  Created by 杨乐栋 on 16/4/18.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "YunGuanHomePageViewController.h"
#import "GeneralWebRequest.h"
#import "TabBarViewController.h"
#import "EntryViewController.h"
#import "NewsTableViewCell.h"
#import "JiaoXiaoNameTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SchoolDetailController.h"
#import "NewsDetialViewController.h"
extern BOOL isMainViewDisplaying;
@interface YunGuanHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) GeneralWebRequest *generalWR;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *newsAry;
@property (nonatomic,strong) NSArray *jiaxiaoAry;
@end

@implementation YunGuanHomePageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
    [self getDataList];
}

-(void)viewDidDisappear:(BOOL)animated{
    isMainViewDisplaying = NO;
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat kwidth=[UIScreen mainScreen].bounds.size.width;
    CGFloat kheight=[UIScreen mainScreen].bounds.size.height;
    
    self.title = @"报名";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self getDataList];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight-64) style:UITableViewStyleGrouped];
    //[tableView setBackgroundColor:[UIColor whiteColor]];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
     tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
//    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.newsAry.count;
    }
    if (section==1) {
        return self.jiaxiaoAry.count;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        NewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewsTableViewCell IDStr]];
        if (!cell) {
            cell=[[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsTableViewCell IDStr]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell.textLabel setFont:[UIFont systemFontOfSize:15]]; 
            
        }
        NSDictionary *dic=self.newsAry[indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"Title"];
        return cell;
    }
    if (indexPath.section==1) {
        JiaoXiaoNameTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[JiaoXiaoNameTableViewCell IDStr]];
        if (!cell) {
            cell=[[JiaoXiaoNameTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[JiaoXiaoNameTableViewCell IDStr] andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 65)];
        }
        NSDictionary *dic=self.jiaxiaoAry[indexPath.row];
        cell.InfoDic=dic;
    
        return cell;
    }
    UITableViewCell *cell=[UITableViewCell new];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        return 65;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 50;
    }
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        CGFloat with =[UIScreen mainScreen].bounds.size.width;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, with, 50)];
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(with/2-100, 20, 200, 20)];
        [titleLab setTextColor:[UIColor darkGrayColor]];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [titleLab setText:@"公告栏"];
        [view addSubview:titleLab];
        UIButton *moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(with-60, 20, 50, 20)];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreNewsBtnAcion) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
        return view;
    }
    UIView *view=[UIView new];
    return view;
}
-(void)moreNewsBtnAcion
{
    
}
-(void)getDataList
{
    if (self.generalWR) {
        [self.generalWR.webRequest clearDelegatesAndCancel];

    }
    self.generalWR=[GeneralWebRequest new];
    __weak typeof(self) weakSelf=self;
    [self.generalWR GetHomePageInfoSuccessBlock:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"Success"] integerValue]) {
              NSDictionary *result=[resultDic objectForKey:@"Result"];
            NSArray *newsAry=[[result objectForKey:@"Noticeresult"] objectForKey:@"Result"];
            weakSelf.newsAry=newsAry;
            NSArray *jiaoxiaoAry=[[result objectForKey:@"Schoolresult"] objectForKey:@"Result"];
            weakSelf.jiaxiaoAry=jiaoxiaoAry;
            
            [weakSelf.tableView reloadData];
        }
      
    } failedBlock:^(NSDictionary *resultDic) {
        
    }];
    
}
-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"left_menu_bar"] forState:UIControlStateNormal];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        NSDictionary *dic=self.newsAry[indexPath.row];
        //NSLog(@"%@",dic);
        NewsDetialViewController *newsdetialViewC=[[NewsDetialViewController alloc]initWithUid:[dic objectForKey:@"Uid"]];
        [self.navigationController pushViewController:newsdetialViewC animated:YES];
        return;
    }
    if(indexPath.section==1)
    {
        NSDictionary *dic=self.jiaxiaoAry[indexPath.row];
        SchoolDetailController *schoolV=[[SchoolDetailController alloc]initWithSchoolUid:[dic objectForKey:@"jxcode"]];
        [self.navigationController pushViewController:schoolV animated:YES];
        return;
    }
}
-(IBAction)showLeftMenu:(id)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.leftMenuController showLeftMenu];
    
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
