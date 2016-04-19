//
//  NewsDetialViewController.m
//  yunguanchuAPP
//
//  Created by 杨乐栋 on 16/4/19.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "NewsDetialViewController.h"
#import "GeneralWebRequest.h"
#define kWith [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface NewsDetialViewController ()
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,strong) GeneralWebRequest *request;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

@implementation NewsDetialViewController
-(id)initWithUid:(NSString *)uid
{
    self=[super init];
    if (self) {
        self.uid=uid;
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告消息";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.request = [[GeneralWebRequest alloc] init];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)getData
{
    NSDictionary *dic=[[NSDictionary alloc]initWithObjects:@[self.uid] forKeys:@[@"Uid"]];
    __weak typeof(self) weakSelf=self;
    [self.request getNewsDetialInfoWithParameter:dic SuccessBlock:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"Success"] integerValue]) {
            weakSelf.dataDic=[resultDic objectForKey:@"Result"];
            [weakSelf creatView];
        }
    } failedBlock:^(NSDictionary *resultDic) {
        
    }];
}
-(void)creatView
{
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, kWith, 20)];
    [titleLab setTextColor:[UIColor darkGrayColor]];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.text=[self.dataDic objectForKey:@"Title"];
    [self.view addSubview:titleLab];
    UILabel *timelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWith/2-10, 15)];
    [timelab setText:[self.dataDic objectForKey:@"Fbsj"]];
    [timelab setFont:[UIFont systemFontOfSize:13]];
    [timelab setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:timelab];
    
    
    UILabel *fbrlab=[[UILabel alloc]initWithFrame:CGRectMake(kWith/2-10, 50, kWith/2-10, 15)];
    [fbrlab setText:[NSString stringWithFormat:@"发布人：%@",[self.dataDic objectForKey:@"Fbr"]]];
    [fbrlab setTextAlignment:NSTextAlignmentRight];
    [fbrlab setFont:[UIFont systemFontOfSize:13]];
    [fbrlab setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:fbrlab];
    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 70, kWith, 0.5)];
    [lineview setBackgroundColor:[UIColor colorWithRed:188/255.f green:188/255.f blue:188/255.f alpha:1]];
    [self.view addSubview:lineview];
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 75, kWith-30, kHeight-135)];
    [self.view addSubview:textView];
    textView.editable=NO;
     [textView setTextColor:[UIColor darkGrayColor]];
    textView.text=[self.dataDic objectForKey:@"Content"];
    
    
    textView.showsVerticalScrollIndicator = NO;
    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showLeftMenu:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
