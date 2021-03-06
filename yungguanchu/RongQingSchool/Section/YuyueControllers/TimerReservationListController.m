//
//  TimerYuyueListController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "TimerReservationListController.h"
#import "ReservationCell.h"
#import "CoachDetailInfoController.h"
#import "TimerReservationItem.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "CoachNameCellTableViewCell.h"
#import<CoreText/CoreText.h>

#import "ZIKMenu2View.h"
static NSInteger sortMarkInteger = 0;
@interface TimerReservationListController ()<ZIKMenu2ViewDelegate>
@property (nonatomic, strong) NSString *orderdate;
@property (nonatomic, strong) NSString *price;//价格区间	说明（以‘|’分割，格式【a|b】表示价格在a与b之间）
@property (nonatomic, strong) NSString *school;//驾校ID集合  说明：驾校id集合（以‘|’分割，格式【a|b|c|】）
@property (nonatomic, strong) NSString *orderby;//排序条件说明：（0:综合排序,1:教龄由高到低,2:星级由高到低,3:价格由高到低）

@property (nonatomic, strong) NSMutableArray *schoolMArr;
@property (nonatomic, strong) ZIKMenu2View *menu2View;
@property (nonatomic, strong) NSMutableArray *timeMArr;

@end

@implementation TimerReservationListController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)sendSchoolAndDateInfo:(NSDictionary *)info {
    self.school = info[@"school"];
    self.selectedDate = info[@"orderdate"];
    [self hideMenu2completion:^(BOOL finished) {
        self.titlePic2.image = [UIImage imageNamed:@"list_arrow_selected"];
        self.titlePic2.transform = CGAffineTransformMakeRotation(M_PI/1000*999.99);

    }];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"viewDidLoad");
    
    
    self.title = @"培训预约";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    self.navigationItem.rightBarButtonItems = [self getRightButtons];
    
    [self initView];
    [self initData];
    //if(self.menu1IsShow){
        [self hideMenu1completion:^(BOOL finished) {

        }];
    //}
    [self requestSchools];
    [self requestData];
}

- (void)initData {
    self.orderby = @"0";
    self.schoolMArr = [NSMutableArray arrayWithCapacity:3];
    self.timeMArr = [NSMutableArray arrayWithCapacity:2];

}


- (void)requestSchools {
    self.requestSchool = [[WebRequest alloc] init];
     [self.requestSchool requestGetWithAction:Action_SchoolList WithParameter:nil successBlock:^(NSDictionary *resultDic) {
         //CLog(@"%@",resultDic);
         if ([resultDic[@"Success"] integerValue] == 1) {
             self.schoolMArr = resultDic[@"Result"];
             if (!self.menu2View) {
                 self.menu2View = [[ZIKMenu2View alloc] initWithFrame:CGRectMake(0, -UISCREEN_SIZE.height*2/3, UISCREEN_SIZE.width, UISCREEN_SIZE.height*2/3) withSchoolArray:self.schoolMArr];
                 self.menu2View.delegate = self;
                 [self.view addSubview:self.menu2View];
             }

         }
         else {
             [Utils showMessage:[NSString stringWithFormat:@"%@",resultDic[@"Msg"]]];

         }

     } failedBlock:^(NSDictionary *resultDic) {
         //CLog(@"%@",resultDic);

     } ];
//    self.requestSchool = [[WebRequest alloc] init];
//    [self.requestSchool requestPostWithAction:Action_SchoolList WithParameter:nil successBlock:^(NSDictionary *resultDic) {
//        CLog(@"%@",resultDic);
//    } failedBlock:^(NSDictionary *resultDic) {
//        CLog(@"%@",resultDic);
//
//    }];
}

-(void)initView{
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"underline_55"] forState:UIControlStateSelected];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.btn1.selected = YES;
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"underline_55"] forState:UIControlStateSelected];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    self.nib = [UINib nibWithNibName:@"ReservationCell2" bundle:nil];
    [self.tableview registerNib:self.nib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
    
    self.nib2 = [UINib nibWithNibName:@"CoachNameCellTableViewCell" bundle:nil];
    [self.coachTableview registerNib:self.nib2 forCellReuseIdentifier:@"cellid"];
    self.coachTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.searchStr = @"";
    self.selectedDate = @"";
    self.selectedCoachID = @"";
    self.sffx = @"0";
    
    self.titleView.layer.cornerRadius = 5;
    self.titleView.layer.masksToBounds = YES;
    if(IS_IOS7){
        self.searchTf.tintColor = [UIColor blueColor];
    }
    
    if([@1 isEqualToNumber:[[UserInfo shareUserInfo].logUserSatate objectForKey:@"K2fxyyState"]] || [@1 isEqualToNumber:[[UserInfo shareUserInfo].logUserSatate objectForKey:@"K3fxyyState"]])
    {
        self.leading.constant = 65;
    }
    
}

-(void)requestData{
    //CLog(@"school:%@",self.school);
    //CLog(@"selectedDate%@",self.selectedDate);
//    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [UserInfo shareUserInfo].uId,@"studentId",
//                               self.selectedDate,@"orderdate",
//                               self.selectedCoachID,@"strjlid",
//                               self.searchStr,@"strsearch",
//                               self.sffx,@"sffx",
//                               self.price,@"price",
//                               self.school,@"school",
//                               self.orderby,@"orderby",
//                               nil];
    NSMutableDictionary *postParam = [NSMutableDictionary dictionary];
    [postParam setObject:[UserInfo shareUserInfo].uId forKey:@"studentId"];//
    [postParam setObject:self.selectedDate forKey:@"orderdate"];//
    postParam[@"strjlid"] = self.selectedCoachID;//
    postParam[@"strsearch"] = self.searchStr;//
    postParam[@"sffx"] = self.sffx;//
    postParam[@"price"] = self.price;
    postParam[@"school"] = self.school;
    postParam[@"orderby"] = self.orderby;//
    //CLog(@"param:%@",postParam);
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_TrainingJlList WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        //CLog(@"%@",resultDic);
        
        //菜单日期
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd";
        
        NSString *nowdateString = [resultDic objectForKey:@"Nowdate"];
        NSDate *nowDate = [df dateFromString:nowdateString];
        NSDate *tomorrowDate = [nowDate dateByAddingTimeInterval:24*3600];
        NSDate *afterTomorrowDate = [tomorrowDate dateByAddingTimeInterval:24*3600];
        NSDate *afterAfterTomorrowDate = [afterTomorrowDate dateByAddingTimeInterval:24*3600];

        if(self.timeMArr){
            [self.timeMArr removeAllObjects];
        }
        else{
            self.timeMArr = [NSMutableArray arrayWithCapacity:2];
        }
        if(self.timeAry){
            [self.timeAry removeAllObjects];
        }
        else{
            self.timeAry = [NSMutableArray arrayWithCapacity:4];
        }

        [self.timeMArr addObjectsFromArray:@[[df stringFromDate:tomorrowDate],
                                           [df stringFromDate:afterTomorrowDate],
                                           [df stringFromDate:afterAfterTomorrowDate]]];
        if (!self.menu2View.timeArr) {
            self.menu2View.timeArr = self.timeMArr;

        }
        [self.timeAry addObjectsFromArray:@[@"默认排序",@"教龄由高到低",@"星级由高到低",@"价格由高到低",@"价格由低到高"]];
        //CLog(@"%@",self.timeAry);
        int i = 0;
        for(UIButton *btn in @[self.dateBtn1,self.dateBtn2,self.dateBtn3,self.dateBtn4,self.dateBtn5]){
            [btn setTitle:[NSString stringWithFormat:@"       %@",self.timeAry[i]] forState:UIControlStateNormal];
            btn.tag = i;
            i++;
        }
//        [self.dateBtn1 setTitleColor:[UIColor colorWithRed:3/255.0 green:180/255.0 blue:248/255.0 alpha:1] forState:UIControlStateNormal];

        //数据源
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic in [resultDic objectForKey:@"Result"]){
            NSError *error;
            TimerReservationItem *item = [TimerReservationItem objectWithKeyValues:dic error:&error];
            if(!error){
                item.nowDate = nowdateString;
                [self.dataAry addObject:item];
            }
        }
        if(!self.dataAry.count){
            [Utils showMessage:@"暂无信息"];
        }
        
        if(self.coachAry){
            [self.coachAry removeAllObjects];
        }
        else{
            self.coachAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        //菜单教练
        for(TimerReservationItem *item in self.dataAry){
            BOOL haveSame = NO;
            for(TimerReservationItem *item2 in self.coachAry){
                if([item.Jlid isEqualToString:item2.Jlid]){
                    haveSame = YES;
                    break;
                }
            }
            if(!haveSame){
                [self.coachAry addObject:item];
            }
        }
        self.height2.constant = self.coachAry.count * 40;
        self.top2.constant = -self.coachAry.count*40 + 40;
        
        [self.tableview reloadData];
        [self.coachTableview reloadData];
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [self.dataAry removeAllObjects];
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
    }];
}

#pragma mark - table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tableview){
        return self.dataAry.count;
    }
    else{
        return self.coachAry.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableview){
        return 128;
    }
    else{
        return 40;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableview){
        ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row%2){
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        else{
            cell.contentView.backgroundColor = UIColorFromRGB(247, 247, 247);
        }
        
        TimerReservationItem *item = self.dataAry[indexPath.row];
        cell.yuyueBtn.tag = indexPath.row;
        [cell.yuyueBtn addTarget:self action:@selector(yuyueAcion:) forControlEvents:UIControlEventTouchUpInside];
        cell.callCtl.tag = indexPath.row;
        [cell.callCtl addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        cell.headPic.layer.masksToBounds=YES;
        cell.headPic.layer.cornerRadius=cell.headPic.frame.size.width/2;
        [cell.headPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",item.Jlpic]] placeholderImage:[UIImage imageNamed:@"teacher_header"]];
        cell.nameLb.text = item.Jlxm;
        cell.sexLb.text = item.Jlxb;
        cell.mobileLb.text = item.Jldh;
        cell.tranNumLabel.text = NSStringFromFormat(@"培训次数:%@",item.tranordernum);
        cell.hpNumLabel.text = NSStringFromFormat(@"好评数:%@",item.hpnum);
        cell.zpNumLabel.text = NSStringFromFormat(@"中评数:%@",item.zpnum);
        cell.cpNumLabel.text = NSStringFromFormat(@"差评数:%@",item.cpnum);
        if (item.Syme.integerValue > 0) {
            [cell.yuyueBtn setTitle:@"可预约" forState:UIControlStateNormal];
        }
        else {
            [cell.yuyueBtn setTitle:@"不可预约" forState:UIControlStateNormal];
        }
        cell.jiaoxiaoLable.text = item.inschool;
        
        NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单价: %@",item.OrderPrice]];
        [ats addAttribute:NSForegroundColorAttributeName
                            value:(id)UIColorFromRGB(102, 102, 102)
                            range:NSMakeRange(0, 4)];
        [ats addAttribute:NSForegroundColorAttributeName
                    value:(id)UIColorFromRGB(225, 131, 9)
                    range:NSMakeRange(4, ats.string.length-4)];
        cell.moneyLb.attributedText = ats;
        
        cell.groupLb.text = item.Jlsszd;
        
        for(UIImageView *starPic in cell.starBgView.subviews){
            if(starPic.tag<= item.CoachStars.intValue){
                starPic.image = [UIImage imageNamed:@"star_full"];
            }
            else{
                starPic.image = [UIImage imageNamed:@"star_blank"];
            }
        }
        
        cell.yearsLb.text = [NSString stringWithFormat:@"%@年教龄",item.Jl];
        
        return cell;
    }
    else{
        CoachNameCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TimerReservationItem *item = self.coachAry[indexPath.row];
        cell.nameLb.text = [NSString stringWithFormat:@"       %@",item.Jlxm];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        CoachDetailInfoController *coachDetailViewController = [[CoachDetailInfoController alloc] init];
        TimerReservationItem *item = self.dataAry[indexPath.row];

        //教练星级如果为空，不让进入预约的详情界面
        if(![Utils isNullOrEmpty:item.CoachStars]){
            item.ordate = self.selectedDate;
            coachDetailViewController.timerReservationItem = item;

            [self.navigationController pushViewController:coachDetailViewController animated:YES];
        }

    }
    if(tableView == self.coachTableview){
        TimerReservationItem *item = self.coachAry[indexPath.row];
        self.selectedCoachID = item.Jlid;
        self.titleLb2.text = item.Jlxm;
        
        [self selectMenu2Btn:nil];
    }
}

//切换教练类型，普通教练和复训教练
-(IBAction)exchangeCoachType:(UIButton *)sender{
    self.sffx = NSStringFromInt(sender.tag);
    sender.selected = YES;
    if(sender == self.coachBtn0){
        self.coachBtn1.selected = NO;
    }
    else{
        self.coachBtn0.selected = NO;
    }
    
    [self requestData];
}

#pragma mark - 菜单弹出
-(IBAction)selectMenu1Btn:(UIButton *)sender{
    self.orderby = NSStringFromInt(sender.tag);
    for(UIButton *btn in @[self.dateBtn1,self.dateBtn2,self.dateBtn3,self.dateBtn4,self.dateBtn5]){
        if (btn.tag == sortMarkInteger) {
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }

    sortMarkInteger = sender.tag;
    [sender setTitleColor:[UIColor colorWithRed:3/255.0 green:180/255.0 blue:248/255.0 alpha:1] forState:UIControlStateNormal];
    self.titleLb1.text = self.timeAry[sender.tag];
    [self showOrHideMenu1:nil];
    
    [self requestData];
}

-(IBAction)selectMenu2Btn:(UIButton *)sender{
    [self showOrHideMenu2:nil];
    
    [self requestData];
}

-(IBAction)showOrHideMenu1:(id)sender{
    if(self.btn1.isSelected){
        if(self.menu1IsShow){
            [self hideMenu1completion:^(BOOL finished) {
                self.titlePic1.image = [UIImage imageNamed:@"list_arrow_selected"];
                self.titlePic1.transform = CGAffineTransformMakeRotation(0);

            }];
        }
        else{
            [self showMenu1];
            self.titlePic1.transform = CGAffineTransformMakeRotation(M_PI/1000*999.99);
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
        [self hideMenu2completion:^(BOOL finished) {
            [self showMenu1];
        }];
        
    }
}

-(IBAction)showOrHideMenu2:(id)sender{
    if(self.btn2.isSelected){
        if(self.menu2IsShow){
            [self hideMenu2completion:^(BOOL finished) {
                self.titlePic2.image = [UIImage imageNamed:@"list_arrow_selected"];
                self.titlePic2.transform = CGAffineTransformMakeRotation(0);

            }];
        }
        else{
            [self showMenu2];
            self.titlePic2.transform = CGAffineTransformMakeRotation(M_PI/1000*999.99);
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
        [self hideMenu1completion:^(BOOL finished) {
            [self showMenu2];
        }];
        
    }
    
}

-(void)hideMenu1completion:(void (^)(BOOL finished))completion1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
//        CGRect r = self.menuBgView1.frame;
//        r.origin.y = CGRectGetMaxY(self.indicatorView.frame)-r.size.height;
//        self.menuBgView1.frame = r;
        self.top1.constant = -self.menuBgView1.frame.size.height+CGRectGetMaxY(self.indicatorView.frame);
        [self.view layoutIfNeeded];
        self.menu1IsShow = NO;
    } completion:^(BOOL finished) {
        self.grayBgControl.hidden = YES;
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        //CLog(@"111111");
        completion1(YES);
    }];
}

-(void)showMenu1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.grayBgControl.hidden = NO;
    if (self.dateBtn1.tag == sortMarkInteger) {
       [self.dateBtn1 setTitleColor:[UIColor colorWithRed:3/255.0 green:180/255.0 blue:248/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.3 animations:^{
//        CGRect r = self.menuBgView1.frame;
//        r.origin.y = CGRectGetMaxY(self.indicatorView.frame);
//        self.menuBgView1.frame = r;
        self.top1.constant = CGRectGetMaxY(self.indicatorView.frame);
        [self.view layoutIfNeeded];
        self.menu1IsShow = YES;
    } completion:^(BOOL finished) {
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        self.grayBgControl.hidden = NO;
    }];
}

-(void)hideMenu2completion:(void (^)(BOOL finished))completion1{
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
//        CGRect r = self.menuBgView2.frame;
//        r.origin.y = CGRectGetMaxY(self.indicatorView.frame)-r.size.height;
//        self.menuBgView2.frame = r;
        self.menu2View.frame = CGRectMake(0, -UISCREEN_SIZE.height*2/3, UISCREEN_SIZE.width, UISCREEN_SIZE.height*2/3);
        //self.top2.constant = -self.menuBgView2.frame.size.height+CGRectGetMaxY(self.indicatorView.frame);
        [self.view layoutIfNeeded];
        self.menu2IsShow = NO;
    } completion:^(BOOL finished) {
        self.grayBgControl.hidden = YES;
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        completion1(YES);
    }];
}

-(void)showMenu2{
    //CLog(@"```````%f",self.menuBgView2.frame.size.height);
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.grayBgControl.hidden = NO;
//    [UIView animateWithDuration:.3 animations:^{
//        self.shopView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
//    }];
//
    [UIView animateWithDuration:0.3 animations:^{
//        CGRect r = self.menuBgView2.frame;
//        r.origin.y = CGRectGetMaxY(self.indicatorView.frame);
//        self.menuBgView2.frame = r;
        self.menu2View.frame = CGRectMake(0, CGRectGetMaxY(self.indicatorView.frame)
, UISCREEN_SIZE.width, UISCREEN_SIZE.height*2/3);
        //self.top2.constant = CGRectGetMaxY(self.indicatorView.frame);
        [self.view layoutIfNeeded];
        self.menu2IsShow = YES;
    } completion:^(BOOL finished) {
        self.btn1.userInteractionEnabled = YES;
        self.btn2.userInteractionEnabled = YES;
        self.grayBgControl.hidden = NO;
        //CLog(@"222222");
    }];
}

-(IBAction)hideAllMenu:(id)sender{
    [self hideMenu1completion:^(BOOL finished) {
        
    }];
    [self hideMenu2completion:^(BOOL finished) {
        
    }];
}

-(void)yuyueAcion:(UIButton *)sender{
    CoachDetailInfoController *coachDetailViewController = [[CoachDetailInfoController alloc] init];
    TimerReservationItem *item = self.dataAry[sender.tag];
    
    //教练星级如果为空，不让进入预约的详情界面
    if(![Utils isNullOrEmpty:item.CoachStars]){
        item.ordate = self.selectedDate;
        coachDetailViewController.timerReservationItem = item;
        
        [self.navigationController pushViewController:coachDetailViewController animated:YES];
    }
    
}

-(IBAction)beginSearchWithKeyword:(id)sender{
    [self hideKeyboard];
    self.searchStr = self.searchTf.text;
    [self requestData];
}

-(void)showSearchBlank{
    if(!self.isTitleViewShow){
        [self.rightItemBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.rightItemBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        self.navigationItem.titleView = self.titleView;
        self.title = @"";
        self.isTitleViewShow = YES;
    }
    else{
        [self.rightItemBtn setTitle:@"" forState:UIControlStateNormal];
        [self.rightItemBtn setBackgroundImage:[UIImage imageNamed:@"serach_white"] forState:UIControlStateNormal];
        
        self.navigationItem.titleView = nil;
        self.title = @"培训预约";
        self.isTitleViewShow = NO;
        
        self.searchTf.text = @"";
        self.searchStr = @"";
    }
}

-(void)hideKeyboard{
    [self.searchTf resignFirstResponder];
}

-(NSArray*)getRightButtons
{
    self.rightItemBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightItemBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.rightItemBtn addTarget:self action:@selector(showSearchBlank) forControlEvents:UIControlEventTouchUpInside];
    [self.rightItemBtn setBackgroundImage:[UIImage imageNamed:@"serach_white"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:self.rightItemBtn];
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

-(void)popview:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 24)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back_small"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
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

-(void)call:(UIControl *)ctrl{
    TimerReservationItem *item = self.dataAry[ctrl.tag];
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
