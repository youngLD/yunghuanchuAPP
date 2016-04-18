//
//  VideoListViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/23.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "VideoListViewController.h"
#import "MJExtension.h"
#import "VideoDownCell.h"
#import "UIImageView+WebCache.h"
#import "DownloadRequest.h"
#import "FileUtil.h"
#import "UIAlertView+XY.h"
#import "VideoDetailViewController.h"
@interface VideoListViewController ()

@end

@implementation VideoListViewController

static VideoListViewController *videoListControlelr;
+(VideoListViewController *)shareInstance{
    if(!videoListControlelr){
        videoListControlelr = [[VideoListViewController alloc] init];
    }
    
    return videoListControlelr;
    
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频下载";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDownloadMessage) name:Notification_Download_Task_Message object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.titleHeaderView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.titleHeaderView.layer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.titleHeaderView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
//    self.titleHeaderView.layer.shadowRadius = 4;//阴影半径，默认3
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.firstTag == 0){
        [self requestVideo0:@"0" isIndex:@"1"];
        self.talbeview1.hidden = YES;
        self.talbeview0.hidden = NO;
        self.titleBtn0.selected = YES;
        self.titleBtn1.selected = NO;
    }
    else{
        [self requestVideo1:@"1" isIndex:@"1"];
        self.talbeview1.hidden = NO;
        self.talbeview0.hidden = YES;
        
        self.titleBtn0.selected = NO;
        self.titleBtn1.selected = YES;
    }
}

-(void)initView{
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.talbeview0.backgroundColor = [UIColor clearColor];
    self.talbeview1.backgroundColor = [UIColor clearColor];
    
    self.nib0 = [UINib nibWithNibName:@"VideoDownCell" bundle:nil];
    [self.talbeview0 registerNib:self.nib0 forCellReuseIdentifier:@"cellid"];
    self.talbeview0.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.nib1 = [UINib nibWithNibName:@"VideoDownCell" bundle:nil];
    [self.talbeview1 registerNib:self.nib1 forCellReuseIdentifier:@"cellid"];
    self.talbeview1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view bringSubviewToFront:self.titleHeaderView];
}

-(IBAction)changeConten:(UIButton *)sender{
    sender.selected = YES;
    if(sender == self.titleBtn0){
        if(!self.isLoadVideo0){
            [self requestVideo0:@"0" isIndex:@"1"];
        }
        
        self.talbeview1.hidden = YES;
        self.talbeview0.hidden = NO;
        self.titleBtn1.selected = NO;
    }
    else{
        if(!self.isLoadVideo1){
            [self requestVideo1:@"1" isIndex:@"1"];
        }
        
        self.talbeview1.hidden = NO;
        self.talbeview0.hidden = YES;
        self.titleBtn0.selected = NO;
    }
    [self.view bringSubviewToFront:self.titleHeaderView];
}

/**
 *  请求视频列表
 *
 *  @param type    科目类型0:科目二，1：科目三
 *  @param isIndex 是否首页 0:首页，1：更多页
 */
-(void)requestVideo0:(NSString *)type isIndex:(NSString *)isIndex{
    if(self.videoRequest0) [self.videoRequest0 clearDelegatesAndCancel];
    self.videoRequest0 = [[VideoWebRequest alloc] init];
    self.isLoadVideo0 = YES;
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               type,@"type",
                               isIndex,@"isIndex",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.videoRequest0 requestPostWithAction:Action_VideoList WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.videoAry0){
            [self.videoAry0 removeAllObjects];
        }
        else{
            self.videoAry0 = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"result"]){
            NSError *error;
            VideoItem *item = [VideoItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.videoAry0 addObject:item];
            }
            
        }
        
        [self.talbeview0 reloadData];
        [Utils removeProgressHUB:self.view];
        [self.view bringSubviewToFront:self.titleHeaderView];
    } failedBlock:^(NSDictionary *resultDic) {
        self.isLoadVideo0 = NO;
        [Utils removeProgressHUB:self.view];
    }];
}

/**
 *  请求视频列表
 *
 *  @param type    科目类型0:科目二，1：科目三
 *  @param isIndex 是否首页 0:首页，1：更多页
 */
-(void)requestVideo1:(NSString *)type isIndex:(NSString *)isIndex{
    if(self.videoRequest1) [self.videoRequest1 clearDelegatesAndCancel];
    self.videoRequest1 = [[VideoWebRequest alloc] init];
    self.isLoadVideo1 = YES;
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               type,@"type",
                               isIndex,@"isIndex",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.videoRequest1 requestPostWithAction:Action_VideoList WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if(self.videoAry1){
            [self.videoAry1 removeAllObjects];
        }
        else{
            self.videoAry1 = [NSMutableArray arrayWithCapacity:20];
        }
        for(NSDictionary *dic in [resultDic objectForKey:@"result"]){
            NSError *error;
            VideoItem *item = [VideoItem objectWithKeyValues:dic error:&error];
            if(!error){
                [self.videoAry1 addObject:item];
            }
            
        }
        
        [self.talbeview1 reloadData];
        [Utils removeProgressHUB:self.view];
        [self.view bringSubviewToFront:self.titleHeaderView];
    } failedBlock:^(NSDictionary *resultDic) {
        self.isLoadVideo1 = NO;
        [Utils removeProgressHUB:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.talbeview0){
        return self.videoAry0.count;
    }
    else{
        return self.videoAry1.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    VideoItem *item;
    if(tableView == self.talbeview0){
        item = self.videoAry0[indexPath.row];
        cell.tag = 0;
    }
    else{
        item = self.videoAry1[indexPath.row];
        cell.tag = 1;
    }
    
    cell.delegate = self;
    [cell.videoPic sd_setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:nil];
    cell.videoPic.layer.cornerRadius = 3;
    cell.videoPic.layer.masksToBounds = YES;
    [Utils autoHeightLabel2:cell.titleLb withString:item.name setFrame:CGRectMake(cell.titleLb.frame.origin.x, cell.titleLb.frame.origin.y, cell.titleLb.frame.size.width, 50) font:cell.titleLb.font];
    cell.progressLb.text = item.size;
    cell.actionBtn.tag = indexPath.row;
    if(tableView == self.talbeview0){
        [cell.actionBtn.layer setValue:@0 forKey:@"table"];
    }
    else{
        [cell.actionBtn.layer setValue:@1 forKey:@"table"];
    }
    
    [cell.actionBtn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *videoName = [[item.videoUrl componentsSeparatedByString:@"/"] lastObject];
    //video文件
    NSString *videoPath = [DoumentDir stringByAppendingPathComponent:videoName];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //已经下载完成
    if([fileManager fileExistsAtPath:videoPath]){
        cell.progressLb.text = [NSString stringWithFormat:@"%.2fM",item.size.floatValue/1000/1000];
        cell.imageProView.hidden = YES;
        cell.imageProBgView.hidden = YES;
        [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"delete_video"] forState:UIControlStateNormal];
    }
    //没有下载完成
    else{
        //临时文件路径
        NSString *tempFilePath = [[DoumentDir stringByAppendingPathComponent:@"temp"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",videoName]];
        //有缓存文件
        if([fileManager fileExistsAtPath:tempFilePath]){
            NSString *s = [FileUtil getFileSize:tempFilePath];
            cell.progressLb.text = [NSString stringWithFormat:@"%.2f/%.2fM",s.floatValue/1000/1000,item.size.floatValue/1000/1000];
            cell.imageProView.frame = CGRectMake(cell.imageProView.frame.origin.x,
                                                 cell.imageProView.frame.origin.y,
                                                 cell.imageProBgView.frame.size.width*(s.floatValue/item.size.floatValue),
                                                 cell.imageProView.frame.size.height);
            
            cell.imageProView.hidden = NO;
            cell.imageProBgView.hidden = NO;
            if([[DownloadRequest shareInstanse] isVideoDownload:item]){
                [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"puase_down"] forState:UIControlStateNormal];
            }
            else{
                [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"start_down"] forState:UIControlStateNormal];
            }
            
        }
        //没有缓存文件
        else{
            cell.progressLb.text = [NSString stringWithFormat:@"%.2fM",item.size.floatValue/1000/1000];
            
            //正在下载
            if([[DownloadRequest shareInstanse] isVideoDownload:item]){
                [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"puase_down"] forState:UIControlStateNormal];
                cell.imageProView.hidden = NO;
                cell.imageProBgView.hidden = NO;
            }
            //没有进行下载
            else{
                [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"start_down"] forState:UIControlStateNormal];
                cell.imageProView.hidden = YES;
                cell.imageProBgView.hidden = YES;
            }
        }
    }
        
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoItem *videoItem;
    if(self.firstTag == 0){
        videoItem = self.videoAry0[indexPath.row];
    }
    else{
        videoItem = self.videoAry1[indexPath.row];
    }
    
    VideoDetailViewController *vd = [[VideoDetailViewController alloc] init];
    vd.videoItem = videoItem;
    [self.navigationController pushViewController:vd animated:YES];
}

-(void)actionClick:(UIButton *)sender{
    UITableView *tableview;
    VideoItem *videoItem;
    if([[sender.layer valueForKey:@"table"] isEqualToNumber:@0]){
        tableview = self.talbeview0;
        videoItem = self.videoAry0[sender.tag];
    }
    else{
        tableview = self.talbeview1;
        videoItem = self.videoAry1[sender.tag];
    }
    VideoDownCell *cell = (VideoDownCell *)[tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    
     NSString *videoName = [[videoItem.videoUrl componentsSeparatedByString:@"/"] lastObject];
    //video文件
    NSString *videoPath = [DoumentDir stringByAppendingPathComponent:videoName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //已经下载完成
    if([fileManager fileExistsAtPath:videoPath]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
            if(btnIndex == 1){
                [fileManager removeItemAtPath:videoPath error:nil];
                [tableview reloadData];
            }
        }];
    }
    //没有下载完成
    else{
        DownloadRequest *downloadRequest = [DownloadRequest shareInstanse];
        if([downloadRequest isVideoDownload:videoItem]){
            [downloadRequest pauseDownload:videoItem];
        }
        else{
            [downloadRequest downVideo:videoItem progressDelegate:cell];
        }
        [tableview reloadData];
    }
    
    
}

- (void)setProgress:(float)newProgress cell:(VideoDownCell *)cell{
    VideoItem *videoItem;
    NSIndexPath *indexPath;
    if(cell.tag == 0){
        indexPath = [self.talbeview0 indexPathForCell:cell];
        videoItem = self.videoAry0[indexPath.row];
    }
    else{
        indexPath = [self.talbeview1 indexPathForCell:cell];
        videoItem = self.videoAry1[indexPath.row];
    }
    cell.imageProView.hidden = NO;
    cell.imageProBgView.hidden = NO;
    cell.progressLb.text = [NSString stringWithFormat:@"%.2f/%.2fM",newProgress*videoItem.size.floatValue/1000/1000,videoItem.size.floatValue/1000/1000];
    //设置自己的进度条
    cell.imageProView.frame = CGRectMake(cell.imageProView.frame.origin.x,
                                         cell.imageProView.frame.origin.y,
                                         cell.imageProBgView.frame.size.width*newProgress,
                                         cell.imageProView.frame.size.height);
    if(newProgress >= 1){
        cell.progressLb.text = [NSString stringWithFormat:@"%.2fM",videoItem.size.floatValue/1000/1000];
        cell.imageProView.hidden = YES;
        cell.imageProBgView.hidden = YES;
    }
}

-(void)receiveDownloadMessage{
    [self.talbeview0 reloadData];
    [self.talbeview1 reloadData];
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
