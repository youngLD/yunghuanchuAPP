//
//  MJZDListViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ArticleViewController.h"
#import "MJZDListViewController.h"
#import "MJZDListCell.h"
#import "MJZDItem.h"
#import "MJExtension.h"
@interface MJZDListViewController ()

@end

@implementation MJZDListViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"秘籍指导";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initViews];
    [self requestData];
}

-(void)initViews{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.nib = [UINib nibWithNibName:@"MJZDListCell" bundle:nil];
    [self.tableView registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)requestData{
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[VideoWebRequest alloc] init];
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"1",@"page",
                               @"1000",@"pageSize",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestPostWithAction:Action_MJZDList WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"result"]){
            NSError *error;
            MJZDItem *item = [MJZDItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
            
        }
        
        [self.tableView reloadData];
        
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MJZDListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MJZDItem *item = self.dataAry[indexPath.row];
    cell.titleLb.text = item.title;
    cell.descLb.text = item.abstr;
    cell.headPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"table_%ld",(long)indexPath.row%7]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MJZDItem *item = self.dataAry[indexPath.row];
    
    ArticleViewController *articleViewControler = [[ArticleViewController alloc] init];
    articleViewControler.isMJZDDetail = YES;
    articleViewControler.uid = item.uid;
    [self.navigationController pushViewController:articleViewControler animated:YES];
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
