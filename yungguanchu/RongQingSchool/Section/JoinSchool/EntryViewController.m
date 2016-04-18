//
//  EntryViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "EntryViewController.h"
#import "EntryCell.h"
#import "TabBarViewController.h"
#import "JoinItem.h"
#import "ViewController.h"
#import "FileUtil.h"
#import "ConfirmJoinController.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"在线报名";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.cellNib = [UINib nibWithNibName:@"EntryCell" bundle:nil];
    self.cellNib2 = [UINib nibWithNibName:@"EntryCell2" bundle:nil];
    [self.tableview registerNib:self.cellNib forCellReuseIdentifier:@"cellid"];
    [self.tableview registerNib:self.cellNib2 forCellReuseIdentifier:@"cellid2"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    [self initData];
    [self.tableview reloadData];
    
    self.tablePicker = [[TablePickerView alloc] initWithFrame:CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, 100)];
    WS(weakSelf);
    [self.tablePicker addBloci:^(NSInteger section, NSInteger row) {

        if(weakSelf.selectedIndexPath.section == 0){
            //学习类型
            if(weakSelf.selectedIndexPath.row == 0){
                NSArray *ary = weakSelf.dataAry[0];
                JoinItem *item = ary[weakSelf.selectedIndexPath.row];
                item.content = weakSelf.studyTypeAry[row];
            }
            //准驾类型
            else if(weakSelf.selectedIndexPath.row == 1){
                NSArray *ary = weakSelf.dataAry[0];
                JoinItem *item = ary[weakSelf.selectedIndexPath.row];
                item.content = weakSelf.carTypeAry[row];
                
                //添加新数据
                for(NSDictionary *dic in [[weakSelf.carDetailDic objectForKey:@"Result"] objectForKey:@"ListChexing"]){
                    JoinItem *stutyTypeItem = [weakSelf.dataAry[0] objectAtIndex:0];
                    JoinItem *carTypeItem = [weakSelf.dataAry[0] objectAtIndex:1];
                    if([stutyTypeItem.content isEqualToString:[dic objectForKey:@"XueXi"]] &&
                       [carTypeItem.content isEqualToString:[dic objectForKey:@"CheXing"]])
                    {
                        NSString *price = [dic objectForKey:@"Price"];
                        JoinItem *priceItem = [weakSelf.dataAry[0] objectAtIndex:3];
                        priceItem.content = price;
                    }
                    
                }
            }
            //学车地点
            else if(weakSelf.selectedIndexPath.row == 2){
                NSArray *ary = weakSelf.dataAry[0];
                JoinItem *item = ary[weakSelf.selectedIndexPath.row];
                item.content = weakSelf.studyAddressAry[row];
            }
            //选择中队
            else if(weakSelf.selectedIndexPath.row == 1000){
                NSArray *ary = weakSelf.dataAry[0];
                JoinItem *item = ary[4];
                item.content = weakSelf.selectGroupAry[row];
                item.content1 = @"请选择介绍人";
            }
            //选择介绍人
            else if(weakSelf.selectedIndexPath.row == 1001){
                NSArray *ary = weakSelf.dataAry[0];
                JoinItem *item = ary[4];
                item.content1 = weakSelf.selectJSRAry[row];
            }
        }
        else{
            //学习类型
            if(weakSelf.selectedIndexPath.row == 1){
                NSArray *ary = weakSelf.dataAry[1];
                JoinItem *item = ary[weakSelf.selectedIndexPath.row];
                item.content = weakSelf.genderAry[row];
            }
        }
        
        [weakSelf actionClick:nil];
        [weakSelf.tableview reloadData];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataAry[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 30)];
    v.backgroundColor = UIColorFromRGB(247, 247, 247);
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    lb.textColor = UIColorFromRGB(80, 80, 80);
    lb.font = [UIFont systemFontOfSize:15];
    if(section == 0){
        lb.text = @"班级类型";
    }
    else{
        lb.text = @"个人信息";
    }
    [v addSubview:lb];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 5, 5)];
    iv.image = [UIImage imageNamed:@"list_correct"];
    [v addSubview:iv];
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 7){
        JoinItem *item07 = self.dataAry[1][7];
        if([Utils isNullOrEmpty:item07.content]){
            return 44;
        }
        else{
            return 60;
        }
    }
    else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EntryCell *cell = nil;
    NSArray *ary = self.dataAry[indexPath.section];
    JoinItem *item = ary[indexPath.row];
    if([@"介绍人" isEqualToString:item.title]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
        cell.titleLb.text = item.title;
        [cell.selectGroupBtn setTitle:item.content forState:UIControlStateNormal];
        [cell.selectZJRBtn setTitle:item.content1 forState:UIControlStateNormal];
        
        [cell.selectGroupBtn addTarget:self action:@selector(reuqestGroup) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectZJRBtn addTarget:self action:@selector(reuqestZJR) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        
        cell.contentTf.delegate = self;
        cell.contentTf.tag = indexPath.row;
        cell.contentBtn.tag = indexPath.row;
        [cell.contentBtn.layer setValue:@(indexPath.section) forKey:@"section"];
        [cell.contentBtn addTarget:self
                            action:@selector(cellDidSelected:)
                  forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(sendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
        if([item.title isEqualToString:@"验证码"]){
            CGRect r = cell.contentTf.frame;
            r.size.width = UISCREEN_SIZE.width-r.origin.x-20 - cell.rightBtn.frame.size.width;
            cell.contentTf.frame = r;
            
            cell.rightBtn.hidden = NO;
        }
        else{
            CGRect r = cell.contentTf.frame;
            r.size.width = UISCREEN_SIZE.width-r.origin.x-10;
            cell.contentTf.frame = r;
            
            cell.rightBtn.hidden = YES;
        }
        
        if([item.title isEqualToString:@"图片"]){
            cell.photoBtn.hidden = NO;
            [cell.photoBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            JoinItem *item07 = self.dataAry[1][7];
            if([Utils isNullOrEmpty:item07.content]){
                cell.photoBtn.frame = CGRectMake(95, 7, 30, 30);
                [cell.photoBtn setBackgroundImage:[UIImage imageNamed:@"addpic"] forState:UIControlStateNormal];
            }
            else{
                cell.photoBtn.frame = CGRectMake(95, 7, 46, 46);
                [cell.photoBtn setBackgroundImage:[UIImage imageWithContentsOfFile:item07.content] forState:UIControlStateNormal];
            }
        }
        else{
            cell.photoBtn.hidden = YES;
        }
        
        cell.titleLb.text = item.title;
        if(indexPath.section==0){
            cell.contentTf.hidden = YES;
            cell.contentBtn.hidden = NO;
            [cell.contentBtn setTitle:item.content forState:UIControlStateNormal];
        }
        else{
            
            if(indexPath.row == 1){
                cell.contentTf.hidden = YES;
                cell.contentBtn.hidden = NO;
                [cell.contentBtn setTitle:item.content forState:UIControlStateNormal];
            }
            else if(indexPath.row == 7){
                cell.contentTf.hidden = YES;
                cell.contentBtn.hidden = YES;
            }
            else{
                cell.contentTf.hidden = NO;
                cell.contentBtn.hidden = YES;
                cell.contentTf.text = item.content;
                cell.contentTf.placeholder = item.placeHolder;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.topLine.hidden = indexPath.row;
    
    
    
    
    return cell;
}

-(void)initData{
    
    JoinItem *item0 = [[JoinItem alloc] initWithTitle:@"学习类型" withContent:@"请选择" withImage:nil placeHolder:nil];
    JoinItem *item1 = [[JoinItem alloc] initWithTitle:@"准驾车型" withContent:@"请选择" withImage:nil placeHolder:nil];
    JoinItem *item2 = [[JoinItem alloc] initWithTitle:@"学车地点" withContent:@"请选择" withImage:nil placeHolder:nil];
    JoinItem *item3 = [[JoinItem alloc] initWithTitle:@"学车费用" withContent:@"" withImage:nil placeHolder:nil];
    JoinItem *item4 = [[JoinItem alloc] initWithTitle:@"介绍人" withContent:@"请选择中队" withContent1:@"请选择介绍人" withImage:nil placeHolder:nil];
    NSMutableArray *ary1 = [NSMutableArray arrayWithObjects:item0,item1,item2,item3,item4, nil];
    
    JoinItem *item00 = [[JoinItem alloc] initWithTitle:@"*姓名" withContent:@"" withImage:nil placeHolder:@"请输入姓名"];
    JoinItem *item01 = [[JoinItem alloc] initWithTitle:@"*性别" withContent:@"请选择" withImage:nil placeHolder:nil];
    JoinItem *item02 = [[JoinItem alloc] initWithTitle:@"*身份证号" withContent:@"" withImage:nil placeHolder:@"请输入身份证号"];
    JoinItem *item03 = [[JoinItem alloc] initWithTitle:@"*手机号码" withContent:@"" withImage:nil placeHolder:@"请输入手机号码"];
    JoinItem *item04 = [[JoinItem alloc] initWithTitle:@"验证码" withContent:@"" withImage:nil placeHolder:@"请输入验证码"];
    JoinItem *item05 = [[JoinItem alloc] initWithTitle:@"家庭住址" withContent:@"" withImage:nil placeHolder:@"请输入家庭住址"];
    JoinItem *item06 = [[JoinItem alloc] initWithTitle:@"备注" withContent:@"" withImage:nil placeHolder:@"请输入备注"];
    JoinItem *item07 = [[JoinItem alloc] initWithTitle:@"图片" withContent:@"" withImage:nil placeHolder:nil];
    NSMutableArray *ary2 = [NSMutableArray arrayWithObjects:item00,item01,item02,item03,item04,item05,item06,item07, nil];
    self.dataAry = [NSMutableArray arrayWithObjects:ary1,ary2, nil];
    
    self.studyTypeAry = [NSMutableArray arrayWithObjects:@"普通班",@"计时班",@"晚班",@"周末班",@"暑假班",@"寒假班", nil];
    
    self.studyAddressAry = [NSMutableArray arrayWithObjects:@"老校区",@"北校区",@"西校区", nil];
    
    self.genderAry = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
}

#pragma mark - table pick view
//点击cell
-(void)cellDidSelected:(UIButton *)sender{
    NSInteger section = [[sender.layer valueForKey:@"section"] integerValue];
    if(section == 0){
        //学习类型
        if(sender.tag == 0){
            [self reInitTablePicker:self.studyTypeAry];
        }
        //准驾车型
        else if(sender.tag == 1){
            JoinItem *item = [self.dataAry[0] objectAtIndex:0];
            if(![item.content isEqualToString:@"请选择"]){
                //是否请求过数据
                if(self.self.carDetailDic){
                    [self getCarTypeAryFromCarDetail];
                }
                else{
                    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
                    if(self.request) [self.request clearDelegatesAndCancel];
                    self.request = [[WebRequest alloc] init];
                    [self.request requestGetWithAction:Action_DropDownGet WithParameter:nil successBlock:^(NSDictionary *resultDic) {
                        self.carDetailDic = resultDic;
                        
                        [self getCarTypeAryFromCarDetail];
                        
                        [Utils removeProgressHUB:self.view];
                    } failedBlock:^(NSDictionary *resultDic) {
                        [Utils removeProgressHUB:self.view];
                    }];
                    
                    
                }
            }
            else{
                [Utils showMessage:@"selectStudyTypeFirst"];
            }
        }
        //学车地点
        else if(sender.tag == 2){
            [self requestAddressAry];
            
        }
    }
    else{
        if(sender.tag == 1){
            [self reInitTablePicker:self.genderAry];
        }
    }
    
    self.selectedIndexPath = [NSIndexPath indexPathForItem:sender.tag inSection:section];
    
    
}

//从车到详细信息中，根据学习类型获取准驾车型
-(void)getCarTypeAryFromCarDetail{
    //清除老数据
    if(self.carTypeAry){
        [self.carTypeAry removeAllObjects];
    }
    else{
        self.carTypeAry = [NSMutableArray arrayWithCapacity:20];
    }
    
    //添加新数据
    for(NSDictionary *dic in [[self.carDetailDic objectForKey:@"Result"] objectForKey:@"ListChexing"]){
        JoinItem *item = [self.dataAry[0] objectAtIndex:0];
        if([item.content isEqualToString:[dic objectForKey:@"XueXi"]]){
            NSString *carType = [dic objectForKey:@"CheXing"];
            [self.carTypeAry addObject:carType];
        }
       
    }
    
    if(self.carTypeAry.count){
        [self reInitTablePicker:self.carTypeAry];
    }
    else{
        [Utils showMessage:@"noDataWithCarType"];
    }
}

//请求中队
-(void)reuqestGroup{
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [self.request requestGetWithAction:Action_JSR WithParameter:nil successBlock:^(NSDictionary *resultDic) {
        CLog(@"%@",resultDic);
        self.jsrDic = resultDic;
        
        if(self.selectGroupAry){
            [self.selectGroupAry removeAllObjects];
        }
        else{
            self.selectGroupAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic in resultDic[@"deptPeople"]){
            [self.selectGroupAry addObject:dic[@"deptName"]];
        }
        
        self.selectedIndexPath = [NSIndexPath indexPathForRow:1000 inSection:0];
        [self reInitTablePicker:self.selectGroupAry];
        
        
        
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

//请求介绍人
-(void)reuqestZJR{
    JoinItem *item = self.dataAry[0][4];
    if([@"请选择中队" isEqualToString:item.content]){
        [Utils showMessage:@"请先选择中队"];
    }
    else{
        for(NSDictionary *dic in self.jsrDic[@"deptPeople"]){
            if([dic[@"deptName"] isEqualToString:item.content]){
                self.selectJSRAry = dic[@"pNames"];
                
                self.selectedIndexPath = [NSIndexPath indexPathForRow:1001 inSection:0];
                [self reInitTablePicker:self.selectJSRAry];
            }
        }
    }
}

-(void)requestAddressAry{
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    if(self.request) [self.request clearDelegatesAndCancel];
    self.request = [[WebRequest alloc] init];
    [self.request requestGetWithAction:Action_GetXQ WithParameter:nil successBlock:^(NSDictionary *resultDic) {
        CLog(@"%@",resultDic);
        
        if(self.studyAddressAry){
            [self.studyAddressAry removeAllObjects];
        }
        else{
            self.studyAddressAry = [NSMutableArray arrayWithCapacity:20];
        }
        
        for(NSDictionary *dic in resultDic[@"xqs"]){
            [self.studyAddressAry addObject:dic[@"xqName"]];
        }
        [self reInitTablePicker:self.studyAddressAry];
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

//弹出picker view 前设置pickerview 属性
-(void)reInitTablePicker:(NSArray *)ary{
    self.tablePicker.dataAry = ary;
    self.tablePicker.frame = CGRectMake(0,
                                        self.tabBarController.view.frame.size.height,
                                        UISCREEN_SIZE.width,
                                        ary.count*kTablePicerHeight);
    [self.tablePicker reloadTableView];
    [self actionShow:nil];
}

-(void)actionShow:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.tablePicker];
    tabbarVc.grayBtn.hidden = NO;
    [tabbarVc.grayBtn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [tabbarVc.view bringSubviewToFront:self.tablePicker];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.tablePicker.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        self.tablePicker.frame = r;
    } completion:^(BOOL finished) {
        
    }];
}

-(IBAction)actionClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.tablePicker.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        self.tablePicker.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.tablePicker removeFromSuperview];
    }];
    
    [tabbarVc.grayBtn removeTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - send verify code
-(void)sendVerifyCode:(UIButton *)sender{
    JoinItem *item = [self.dataAry[1] objectAtIndex:3];
    if(![Utils isNullOrEmpty:item.content] && item.content.length == 11){
        if(self.verifyCodeRequest)[self.verifyCodeRequest.webRequest clearDelegatesAndCancel];
        self.verifyCodeRequest = [[GeneralWebRequest alloc] init];
        
        [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
        [self.verifyCodeRequest requestPhoneVerifyCodePhone:item.content successBlock:^(NSDictionary *resultDic) {
            [Utils showMessage:@"verifyCodeSendSuccess"];
            self.cutDownTime = 60;
            [self timeCountDown];
            [Utils removeProgressHUB:self.view];
            
            //验证码，本地验证
            self.verifyCode = [resultDic objectForKey:@"VerifyCode"];
            
        } failedBlock:^(NSDictionary *resultDic) {
            [Utils removeProgressHUB:self.view];
        }];
    }
    else{
        [Utils showMessage:@"请填写正确的手机号"];
    }
}

-(void)timeCountDown{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - photo select
-(void)selectPhoto:(UIButton *)sender{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    [myActionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self LocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
}
//从相册选择
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else {
        NSLog(@"该设备无摄像头");
    }
}
#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        UIImage *newimage = [Utils fixOrientation:image];
        NSData * imageData = UIImageJPEGRepresentation(newimage,1);
        CGFloat length = [imageData length]/1024;
        if(length>1000){
            imageData = UIImageJPEGRepresentation(newimage,0.7);
        }
        
        //document目录
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        //要创建文件夹的完整目录
        NSString *imagePath = [doc stringByAppendingPathComponent:@"head.jpg"];
        
        if([[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil]){
            JoinItem *item07 = self.dataAry[1][7];
            item07.content = imagePath;
            
            CLog(@"%@",[FileUtil getFileSize:imagePath]);
            [self.tableview reloadData];
        }
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}

-(void)time:(NSTimer *)timer_{
    if(self.cutDownTime > 0){
        self.cutDownTime --;
        EntryCell *cell = (EntryCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:1]];
        if(cell){
            [cell.rightBtn setTitle:NSStringFromInt(self.cutDownTime) forState:UIControlStateNormal];
            cell.rightBtn.enabled = NO;
        }
        
    }
    else{
        self.cutDownTime = 60;
        EntryCell *cell = (EntryCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:1]];
        if(cell){
            [cell.rightBtn setTitle:@"获取" forState:UIControlStateNormal];
            cell.rightBtn.enabled = YES;
        }
        
        [self.timer invalidate];
        
    }
    
}

-(IBAction)commit{
    NSMutableDictionary *postParam = [NSMutableDictionary dictionaryWithCapacity:20];
 
    NSArray *ary0 = self.dataAry[0];
    NSArray *ary1 = self.dataAry[1];
    
    JoinItem *item04 = ary1[4];
    if(![item04.content isEqualToString:self.verifyCode]){
        [Utils showMessage:@"verifyCodeWrong"];
        return;
    }
    
    JoinItem *item0 = ary0[0];
    if(![Utils isNullOrEmpty:item0.content] && ![@"请选择" isEqualToString:item0.content]){
        [postParam setObject:item0.content forKey:@"xxlx"];
    }
    else{
        [Utils showMessage:@"pleaseSelectStudyType"];
        return;
    }
    
    JoinItem *item1 = ary0[1];
    if(![Utils isNullOrEmpty:item1.content] && ![@"请选择" isEqualToString:item1.content]){
        [postParam setObject:item1.content forKey:@"chexing"];
    }
    else{
        [Utils showMessage:@"pleaseSelectCarType"];
        return;
    }
    
    JoinItem *item2 = ary0[2];
    if(![Utils isNullOrEmpty:item2.content] && ![@"请选择" isEqualToString:item2.content]){
        [postParam setObject:item2.content forKey:@"xiaoqu"];
    }
    else{
        [Utils showMessage:@"pleaseSelectStudyAddress"];
        return;
    }
    
    JoinItem *item3 = ary0[3];
    if(![Utils isNullOrEmpty:item3.content] && ![@"请选择" isEqualToString:item3.content]){
        [postParam setObject:item3.content forKey:@"price"];
    }
    else{
        [Utils showMessage:@"异常"];
        return;
    }
    
    JoinItem *item4 = ary0[4];
    if(![Utils isNullOrEmpty:item4.content1] && ![@"请选择介绍人" isEqualToString:item4.content1]){
        [postParam setObject:item4.content1 forKey:@"yyr"];
    }
    else{
        [Utils showMessage:@"pleaseSelectYYR"];
        return;
    }
    
    JoinItem *item00 = ary1[0];
    if(![Utils isNullOrEmpty:item00.content] && ![@"请选择" isEqualToString:item00.content]){
        [postParam setObject:item00.content forKey:@"name"];
    }
    else{
        [Utils showMessage:@"pleaseInputName"];
        return;
    }
    
    JoinItem *item01 = ary1[1];
    if(![Utils isNullOrEmpty:item01.content] && ![@"请选择" isEqualToString:item01.content]){
        [postParam setObject:item01.content forKey:@"gender"];
    }
    else{
        [Utils showMessage:@"pleaseSelectGender"];
        return;
    }
    
    JoinItem *item02 = ary1[2];
    if(![Utils isNullOrEmpty:item02.content] && ![@"请选择" isEqualToString:item02.content]){
        [postParam setObject:item02.content forKey:@"personId"];
    }
    else{
        [Utils showMessage:@"pleaseInputIDCard"];
        return;
    }
    
    JoinItem *item03 = ary1[3];
    if(![Utils isNullOrEmpty:item03.content] && ![@"请选择" isEqualToString:item03.content]){
        [postParam setObject:item03.content forKey:@"mobile"];
    }
    else{
        [Utils showMessage:@"pleaseInputMobile"];
        return;
    }
    
    JoinItem *item05 = ary1[5];
    [postParam setObject:item05.content forKey:@"address"];
    
    JoinItem *item06 = ary1[6];
    [postParam setObject:item06.content forKey:@"note"];
    
    JoinItem *item07 = ary1[7];
    /*
    NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSBundle mainBundle] pathForResource:@"200831391824443_2" ofType:@"jpg"],@"imgHead", nil];
     */
    
    
    NSArray *images;
    if([Utils isNullOrEmpty:item07.content]){
        images = nil;
    }
    else{
        NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:item07.content,@"imgHead", nil];
        images = [NSArray arrayWithObjects:imageDic, nil];
    }
    
    
    JoinItem *priceItem = [self.dataAry[0] objectAtIndex:3];
    
    ConfirmJoinController *confirmJoinController = [[ConfirmJoinController alloc] init];
    confirmJoinController.images = images;
    confirmJoinController.postParam = postParam;
    confirmJoinController.totalMoney = priceItem.content;
    [self.navigationController pushViewController:confirmJoinController animated:YES];
    
    /*
    if(self.commitRequet)[self.commitRequet clearDelegatesAndCancel];
    self.commitRequet = [[WebRequest alloc] init];
    self.commitRequet.imageAry = images;
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.commitRequet requestPostWithAction:Action_OnlineRegis WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"报名成功" message:@"登陆名是身份证号，密码是手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
     */
    /*
     "pleaseSelectStudyType" = "请选择学习类型";
     "pleaseSelectCarType" = "请选择准驾类型";
     "pleaseSelectStudyAddress" = "请选择学车地点";
     "pleaseInputName" = "请输入姓名";
     "pleaseSelectGender" = "请选择性别";
     "pleaseInputIDCard" = "请输入身份证号";
     "pleaseInputMobile" = "请输入手机号码";
     "pleaseInputVerifyCode" = "请输入验证码";
     "pleaseInputMobile" = "请输入手机号码";
     */
    
}

#pragma mark - textfiled delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    JoinItem *item = [self.dataAry[1] objectAtIndex:textField.tag];
    item.content = textField.text;
    CLog(@"%@-%@",item.title,item.content);
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
