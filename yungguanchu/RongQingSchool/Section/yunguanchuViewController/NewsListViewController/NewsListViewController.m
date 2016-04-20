//
//  NewsListViewController.m
//  yunguanchuAPP
//
//  Created by 杨乐栋 on 16/4/19.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "NewsListViewController.h"
#import "MJRefresh.h"
#import "NewsTableViewCell.h"
#import "GeneralWebRequest.h"
#import "NewsDetialViewController.h"
@interface NewsListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataAry;
@property (nonatomic,strong)GeneralWebRequest *request;
@property (nonatomic) NSInteger PageCount;
@end

@implementation NewsListViewController
-(id)init
{
    self=[super init];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}
-(void)getDataList
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@"1",[NSString stringWithFormat:@"%ld",_PageCount]] forKeys:@[@"ismore",@"page"]];
    [self.request GetHomePageInfoWith:dic SuccessBlock:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"Success"] integerValue]) {
            NSArray *aryy = [[[resultDic objectForKey:@"Result"] objectForKey:@"Noticeresult"] objectForKey:@"Result"];
            
            NSDictionary *xxDic=[self.dataAry lastObject];
            NSDictionary *ddDic=[aryy lastObject];
            if ([[xxDic objectForKey:@"Uid"] isEqualToString:[ddDic objectForKey:@"Uid"]]) {
                _PageCount--;
                if (_PageCount<0) {
                    _PageCount=0;
                }
               
            }else{
                [self.dataAry addObjectsFromArray:aryy];
                [self.tableView reloadData];
            }
            if (aryy.count==0) {
                _PageCount--;
                if (_PageCount<0) {
                    _PageCount=0;
                }
                
            }
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    } failedBlock:^(NSDictionary *resultDic) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}
- (void)viewDidLoad {
    CGFloat Width=[UIScreen mainScreen].bounds.size.width;
    CGFloat Height=[UIScreen mainScreen].bounds.size.height;
    [super viewDidLoad];
    _PageCount=0;
    self.title = @"公告栏";
    self.dataAry=[NSMutableArray array];
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width,Height-100) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
      tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf=self;
    [self.tableView addHeaderWithCallback:^{
        [weakSelf.dataAry removeAllObjects];
        weakSelf.PageCount=0;
        [weakSelf getDataList];
    }];
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.PageCount++;
        [weakSelf getDataList];
    }];
    self.request=[GeneralWebRequest new];
    [self getDataList];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewsTableViewCell IDStr]];
    if (!cell) {
        cell=[[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsTableViewCell IDStr]];
    }
    NSDictionary *dic=self.dataAry[indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"Title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        NSDictionary *dic=self.dataAry[indexPath.row];
        //NSLog(@"%@",dic);
        NewsDetialViewController *newsdetialViewC=[[NewsDetialViewController alloc]initWithUid:[dic objectForKey:@"Uid"]];
        [self.navigationController pushViewController:newsdetialViewC animated:YES];
        return;
    }
    
}
-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 0, 43, 34)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //    [backbtn setTitle:@"♬" forState:UIControlStateNormal];
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
-(void)showLeftMenu:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
