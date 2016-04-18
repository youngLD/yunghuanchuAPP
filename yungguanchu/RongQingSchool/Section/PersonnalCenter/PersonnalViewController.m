//
//  PersonnalViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "PersonnalViewController.h"
#import "ChangePasswordController.h"
#import "ChangeUsernameController.h"
#import "UIButton+WebCache.h"
#import "FileUtil.h"

@interface PersonnalViewController ()

@end

@implementation PersonnalViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initView];
    
    //登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initView) name:Notification_Login_Success object:nil];
}

-(void)initView{
    self.bgScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, 556+15);
    self.bgScrollView.backgroundColor = MAIN_VIEW_COLOR;
    self.bgScrollView.alwaysBounceVertical = YES;
    
    self.nameLb.text = [UserInfo shareUserInfo].name;
    if([Utils isNullOrEmpty:[UserInfo shareUserInfo].name]){
        self.nameLb.text = @"未设置";
    }
    self.aplyLb.text = [UserInfo shareUserInfo].applyDate;
    self.userNameLb.text = [UserInfo shareUserInfo].appUserName;
    self.carTypeLb.text = [UserInfo shareUserInfo].cheXing;
    self.studyTypeLb.text = [UserInfo shareUserInfo].xxlx;
    self.studyAddressLb.text = [UserInfo shareUserInfo].learnLocation;
    self.currentStateLb.text = [UserInfo shareUserInfo].currentState;
    self.mobileLb.text = [UserInfo shareUserInfo].mobile;
    self.idCardLb.text = [UserInfo shareUserInfo].personIdentify;
    [self.headPicBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[UserInfo shareUserInfo].appHeadPic]]
                                           forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head_pic"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                               
                                           }];
    self.headPicBtn.layer.cornerRadius = self.headPicBtn.frame.size.width/2;
    self.headPicBtn.layer.masksToBounds = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

-(IBAction)gotoChangeUsername:(id)sender{
    ChangeUsernameController *changeUsername = [[ChangeUsernameController alloc] init];
    [self.navigationController pushViewController:changeUsername animated:YES];
}

-(IBAction)gotoChangePasssword:(id)sender{
    ChangePasswordController *changePassword = [[ChangePasswordController alloc] init];
    [self.navigationController pushViewController:changePassword animated:YES];
}

-(IBAction)logout{
    [[UserInfo shareUserInfo] clearInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Logout_Success object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [Utils showMessage:@"logoutSuccess"];
}

-(void)commitHeadPic{
    //document目录
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //完整目录
    NSString *imagePath = [doc stringByAppendingPathComponent:@"head.jpg"];
    
    NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:imagePath,@"headpic", nil];
    NSArray *images = [NSArray arrayWithObjects:imageDic, nil];
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid", nil];
    
    if(self.commitRequet)[self.commitRequet clearDelegatesAndCancel];
    self.commitRequet = [[WebRequest alloc] init];
    self.commitRequet.imageAry = images;
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.commitRequet requestPostWithAction:Action_HeadPic WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"changeHeadPicutreSuccess"];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Need_Relogin object:nil];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

#pragma mark - photo select
-(IBAction)selectPhoto:(UIButton *)sender{
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
        
        //完整目录
        NSString *imagePath = [doc stringByAppendingPathComponent:@"head.jpg"];
        
        if([[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil]){
            
        }
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [self commitHeadPic];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
