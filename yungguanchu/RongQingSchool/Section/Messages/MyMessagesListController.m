//
//  MyMessagesListController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/7.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "MyMessagesListController.h"
#import "MessageItem.h"
#import "MJExtension.h"
#import "MyMessageCell.h"

@interface MyMessagesListController ()

@end

@implementation MyMessagesListController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通知消息";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    [self initView];
    
    [self requestData];
}

-(void)initView{
    self.cellNib = [UINib nibWithNibName:@"MyMessageCell" bundle:nil];
    [self.tableview registerNib:self.cellNib forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = MAIN_VIEW_COLOR;
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"stuId",nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_GetMsg WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.dataAry){
            [self.dataAry removeAllObjects];
        }
        else{
            self.dataAry = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"stuMsg"]){
            NSError *error;
            MessageItem *item = [MessageItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.dataAry addObject:item];
            }
        }
        [self.tableview reloadData];
        [Utils removeProgressHUB:self.view];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageItem *item = self.dataAry[indexPath.row];
    if(item.isExpand){
        CGSize size = [item.sMsg sizeWithFont:[UIFont systemFontOfSize:15]
                            constrainedToSize:CGSizeMake(UISCREEN_SIZE.width-20, 1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
        
        return size.height+10+47+10;
    }
    else{
        return 50;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = MAIN_VIEW_COLOR;
    cell.contentView.clipsToBounds = YES;
    cell.contenBgView.clipsToBounds = YES;
    
    MessageItem *item = self.dataAry[indexPath.row];
    cell.titleLb.text = item.sName;
    cell.timeLb.text = [item.sendTime substringFromIndex:5];
    cell.contentLb.text = item.sMsg;
    if([@"0" isEqualToString:item.nType]){
        cell.headPic.image = [UIImage imageNamed:@"message_new"];
    }
    else{
        cell.headPic.image = [UIImage imageNamed:@"message_open"];
    }
    
    if(item.isExpand){
        CGSize size = [item.sMsg sizeWithFont:[UIFont systemFontOfSize:15]
                            constrainedToSize:CGSizeMake(UISCREEN_SIZE.width-20, 1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
        CGRect r = cell.contentLb.frame;
        r.size.height = size.height;
        
        cell.arrowPic.transform = CGAffineTransformMakeRotation(M_PI/2/1000*999.9999);
        
    }
    else{
        cell.arrowPic.transform = CGAffineTransformMakeRotation(0);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageItem *item = self.dataAry[indexPath.row];
    if([@"0" isEqualToString:item.nType]){
        [self readMessage:item];
    }
    item.isExpand = !item.isExpand;
    item.nType = @"1";
    [tableView reloadData];
}

-(void)readMessage:(MessageItem *)item{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"stuId",
                               item.nid,@"readMsgId",nil];
    
    if(self.request){
        [self.request clearDelegatesAndCancel];
    }
    self.request = [[WebRequest alloc] init];
    [self.request requestGetWithAction:Action_GetMsg WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        
    } failedBlock:^(NSDictionary *resultDic) {
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
