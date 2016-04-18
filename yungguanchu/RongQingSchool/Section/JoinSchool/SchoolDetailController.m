//
//  JoinSchoolController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/21.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "SchoolDetailController.h"
#import "TabBarViewController.h"
#import "EntryViewController.h"
#import "WayListCell.h"
#import "UIButton+EnlargeArea.h"
#import "MapViewController.h"
#import "JSONKit.h"
extern BOOL isMainViewDisplaying;

@interface SchoolDetailController ()

@end

@implementation SchoolDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"驾校详情";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    self.navigationItem.rightBarButtonItems = [self getNewRightButtons];
    
    [self initView];
    [self requestData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    isMainViewDisplaying = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    isMainViewDisplaying = NO;
    [super viewDidDisappear:animated];
}

-(void)initView{
    self.bgScrollView.alwaysBounceVertical = YES;
    self.bgScrollView.backgroundColor = MAIN_VIEW_COLOR;
    self.headerBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.headerBgView.layer.borderWidth = 0.5;
    
    self.jianjieBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.jianjieBgView.layer.borderWidth = 0.5;
    
    self.liuchengBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.liuchengBgView.layer.borderWidth = 0.5;
    
    self.bancheBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.bancheBgView.layer.borderWidth = 0.5;
    
    self.putongBanBtn.layer.borderColor = UIColorFromRGB(0, 182, 248).CGColor;
    self.putongBanBtn.layer.borderWidth = 1;
    self.putongBanBtn.layer.cornerRadius = 4;
    
    self.jishiBanBtn.layer.borderColor = UIColorFromRGB(0, 182, 248).CGColor;
    self.jishiBanBtn.layer.borderWidth = 1;
    self.jishiBanBtn.layer.cornerRadius = 4;
    
    self.cellNib = [UINib nibWithNibName:@"WayListCell" bundle:nil];
    [self.wayTableView registerNib:self.cellNib forCellReuseIdentifier:@"cellid"];
    self.wayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CGSize s = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.bancheBgView.frame)+5);
    self.bgScrollView.contentSize = s;
    
    [self.expandBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMap)];
    [self.schoolAddressLb addGestureRecognizer:tap1];
    self.schoolAddressLb.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callScholl)];
    [self.schoolTelLb addGestureRecognizer:tap2];
    self.schoolTelLb.userInteractionEnabled = YES;
}

-(void)requestData{
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_SchoolInf WithParameter:nil successBlock:^(NSDictionary *resultDic) {
        
        [self layoutViews:resultDic];
        [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"school_info"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } failedBlock:^(NSDictionary *resultDic) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"school_info"];
        [self layoutViews:dic];
    }];
}

-(void)layoutViews:(NSDictionary *)resultDic{
    self.dataDic = [resultDic objectForKey:@"school"];
    self.schoolNameLb.text = [self.dataDic objectForKey:@"schoolName"];
    self.schoolAddressLb.text = [NSString stringWithFormat:@"地址: %@",[self.dataDic objectForKey:@"schoolAddress"]];
    self.schoolTelLb.text = [NSString stringWithFormat:@"电话: %@",[self.dataDic objectForKey:@"telephone"]];
    
    [Utils autoHeightLabel2:self.schoolDescLb
                 withString:[self.dataDic objectForKey:@"shoolNote"]
                   setFrame:CGRectMake(self.schoolDescLb.frame.origin.x,
                                       self.schoolDescLb.frame.origin.y,
                                       self.schoolDescLb.frame.size.width, 90)
                       font:[UIFont systemFontOfSize:15]];
    
    
    self.wayAry = [self.dataDic objectForKey:@"lisWays"];
    [self.wayTableView reloadData];
    self.wayTableView.frame = CGRectMake(self.wayTableView.frame.origin.x,
                                         self.wayTableView.frame.origin.y,
                                         self.wayTableView.frame.size.width,
                                         self.wayTableView.contentSize.height);
    CGRect r = self.bancheBgView.frame;
    r.size.height = CGRectGetMaxY(self.wayTableView.frame);
    self.bancheBgView.frame = r;
    
    CGSize s = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.bancheBgView.frame)+5);
    self.bgScrollView.contentSize = s;
    
    [Utils removeProgressHUB:self.view];
}

-(IBAction)showLiuchengType:(UIButton *)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.view bringSubviewToFront:tabbarVc.grayBtn];
    [tabbarVc.grayBtn addTarget:self action:@selector(hideLiuchengType:) forControlEvents:UIControlEventTouchUpInside];
    
   [self.tabBarController.view addSubview:self.banjiTypeBgView];
    self.banjiTypeBgView.frame = CGRectMake((UISCREEN_SIZE.width-self.banjiTypeBgView.frame.size.width)/2,
                                            (UISCREEN_SIZE.height-self.banjiTypeBgView.frame.size.height)/2,
                                            self.banjiTypeBgView.frame.size.width,
                                            self.banjiTypeBgView.frame.size.height);
    self.banjiTypeBgView.layer.cornerRadius = 5;
    self.banjiTypeBgView.layer.borderColor = UIColorFromRGB(220, 220, 220).CGColor;
    self.banjiTypeBgView.layer.borderWidth = 1;
    
    
    if(sender.tag == 1){
        self.banjiTypeLb.text = @"普通班";
        self.banjiTypeImageView.image = [UIImage imageNamed:@"putongban_liucheng"];
    }
    else{
        self.banjiTypeLb.text = @"计时班";
        self.banjiTypeImageView.image = [UIImage imageNamed:@"jishiban_liucheng"];
    }
    
}

-(IBAction)hideLiuchengType:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    tabbarVc.grayBtn.hidden = YES;
    [self.banjiTypeBgView removeFromSuperview];
    
    [tabbarVc.grayBtn removeTarget:self action:@selector(hideLiuchengType:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)gotoEntry{
    EntryViewController *entryViewController = [[EntryViewController alloc] init];
    [self.navigationController pushViewController:entryViewController animated:YES];
}

-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"left_menu_bar"] forState:UIControlStateNormal];
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

-(NSArray*)getNewRightButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 71, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(gotoEntry) forControlEvents:UIControlEventTouchUpInside];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [backbtn setTitle:@"在线报名" forState:UIControlStateNormal];
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

-(IBAction)showLeftMenu:(id)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.leftMenuController showLeftMenu];
    
}

-(IBAction)explandOrNot:(UIButton *)sender{
    if(sender.tag == 0){
        [Utils autoHeightLabel2:self.schoolDescLb
                     withString:[self.dataDic objectForKey:@"shoolNote"]
                       setFrame:CGRectMake(self.schoolDescLb.frame.origin.x,
                                           self.schoolDescLb.frame.origin.y,
                                           self.schoolDescLb.frame.size.width, 1000)
                           font:[UIFont systemFontOfSize:15]];
        
        [self layoutView];
        
        self.expandBtn.transform = CGAffineTransformMakeRotation(M_PI/1000*999.999);
        
        sender.tag = 1;
        
    }
    else{
        [Utils autoHeightLabel2:self.schoolDescLb
                     withString:[self.dataDic objectForKey:@"shoolNote"]
                       setFrame:CGRectMake(self.schoolDescLb.frame.origin.x,
                                           self.schoolDescLb.frame.origin.y,
                                           self.schoolDescLb.frame.size.width, 90)
                           font:[UIFont systemFontOfSize:15]];
        
        [self layoutView];
        
        self.expandBtn.transform = CGAffineTransformMakeRotation(0);
        
        sender.tag = 0;
    }
}

-(void)layoutView{
    CGRect r = self.jianjieBgView.frame;
    r.size.height = CGRectGetMaxY(self.schoolDescLb.frame)+15;
    self.jianjieBgView.frame = r;
    
    r = self.expandBtn.frame;
    r.origin.y = CGRectGetMaxY(self.schoolDescLb.frame)+1;
    self.expandBtn.frame = r;
    
    r = self.liuchengBgView.frame;
    r.origin.y = CGRectGetMaxY(self.jianjieBgView.frame)+15;
    self.liuchengBgView.frame = r;
    
    r = self.bancheBgView.frame;
    r.origin.y = CGRectGetMaxY(self.liuchengBgView.frame)+15;
    self.bancheBgView.frame = r;
    
    CGSize s = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.bancheBgView.frame)+5);
    self.bgScrollView.contentSize = s;
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wayAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *wayString = [NSString stringWithFormat:@"线路%d: %@",(int)(indexPath.row+1),self.wayAry[indexPath.row]];
    CGSize labelSize = [wayString sizeWithFont:[UIFont systemFontOfSize:15]
                          constrainedToSize:CGSizeMake(UISCREEN_SIZE.width-24, 1000)
                              lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.height + 24;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WayListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     NSString *wayString = [NSString stringWithFormat:@"线路%d: %@",(int)(indexPath.row+1),self.wayAry[indexPath.row]];
    [Utils autoHeightLabel2:cell.wayLb withString:wayString setFrame:CGRectMake(12, 12, UISCREEN_SIZE.width-24, 1000) font:[UIFont systemFontOfSize:15]];
    
    return cell;
}

-(void)gotoMap{
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.address = [self.dataDic objectForKey:@"schoolAddress"];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

-(void)callScholl{
    NSString *s = [NSString stringWithFormat:@"tel://%@",[self.dataDic objectForKey:@"telephone"]];
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
