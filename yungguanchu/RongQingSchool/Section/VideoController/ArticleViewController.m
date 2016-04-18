//
//  AiticleViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    [self initViews];
    if(!_isMJZDDetail){
        [self requestData];
    }
    else{
        [self requestData2];
    }
    
}

-(void)initViews{
    
}

-(void)requestData{
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[VideoWebRequest alloc] init];
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               NSStringFromInt(self.flag),@"flag",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestPostWithAction:Action_ArticleDetail WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        NSString *content = [[resultDic objectForKey:@"result"] objectForKey:@"content"];
        [self.webView loadHTMLString:content baseURL:nil];
        long t = [[[resultDic objectForKey:@"result"] objectForKey:@"updateTime"] longValue];
        self.timeLb.text = [Utils getmfDateFromDotNetJSONString:[NSString stringWithFormat:@"%ld",t]];
        self.titleLb.text = [[resultDic objectForKey:@"result"] objectForKey:@"title"];
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(void)requestData2{
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[VideoWebRequest alloc] init];
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.uid,@"uid",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestPostWithAction:Action_MJZDDetail WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        NSString *content = [[resultDic objectForKey:@"result"] objectForKey:@"content"];
        [self.webView loadHTMLString:content baseURL:nil];
        long t = [[[resultDic objectForKey:@"result"] objectForKey:@"updateTime"] longValue];
        self.timeLb.text = [Utils getmfDateFromDotNetJSONString:[NSString stringWithFormat:@"%ld",t]];
        self.titleLb.text = [[resultDic objectForKey:@"result"] objectForKey:@"title"];
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
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
