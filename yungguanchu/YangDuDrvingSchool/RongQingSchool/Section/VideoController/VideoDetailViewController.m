//
//  VideoDetailViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "MJExtension.h"
#import "UIButton+EnlargeArea.h"

@interface VideoDetailViewController ()
@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@end

@implementation VideoDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"视频详情";
//    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    [self initViews];
    
    [self requestVideo];
}

-(void)initViews{
    //create a player
    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 200)];
    self.moviePlayer.view.alpha = 1.f;
    self.moviePlayer.delegate = self; //IMPORTANT!
    
    
    
    //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    //[movieControls setAdjustsFullscreenImage:NO];
    [movieControls setBarColor:[UIColor colorWithRed:6/255.0 green:4/255.0 blue:2/255.0 alpha:0.4]];
    [movieControls setTimeRemainingDecrements:NO];
    
    NSString *videoName = [[self.videoItem.videoUrl componentsSeparatedByString:@"/"] lastObject];
    NSString *localPath = [DoumentDir stringByAppendingPathComponent:videoName];
    
    //[movieControls setFadeDelay:2.0];
    //[movieControls setBarHeight:100.f];
    //[movieControls setSeekRate:2.f];
    
    //assign controls
    [self.moviePlayer setControls:movieControls];
    [self.view addSubview:self.moviePlayer.view];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:localPath]){
//        movieControls.videoPath = localPath;
        [self.moviePlayer setContentURL:[NSURL fileURLWithPath:localPath]];
    }
    else{
//        movieControls.videoPath = self.videoItem.videoUrl;
        [self.moviePlayer setContentURL:[NSURL URLWithString:self.videoItem.videoUrl]];
    }
    self.moviePlayer.shouldAutoplay = NO;
    [self.moviePlayer prepareToPlay];
    CGRect r = self.webView.frame;
    r.origin.y = self.moviePlayer.view.frame.size.height+15;
    r.size.height = UISCREEN_SIZE.height - r.origin.y-10;
    self.webView.frame = r;
    
    [self.view bringSubviewToFront:self.backBtn];
    [self.backBtn setEnlargeEdgeWithTop:20 right:20 bottom:30 left:30];
}

/**
 *  请求视频列表
 *
 *  @param type    科目类型0:科目二，1：科目三
 *  @param isIndex 是否首页 0:首页，1：更多页
 */
-(void)requestVideo{
    if(self.videoRequest) [self.videoRequest clearDelegatesAndCancel];
    self.videoRequest = [[VideoWebRequest alloc] init];

    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.videoItem.uid,@"uid",nil];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.videoRequest requestPostWithAction:Action_VideoDetail WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        NSError *error;
        self.detailVideoItem = [VideoItem objectWithKeyValues:[resultDic objectForKey:@"result"] error:&error];
        if(!error){
            [self.webView loadHTMLString:self.detailVideoItem.content baseURL:nil];
        }
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

//IMPORTANT!
- (void)moviePlayerWillMoveFromWindow {
    //movie player must be readded to this view upon exiting fullscreen mode.
    if (![self.view.subviews containsObject:self.moviePlayer.view])
        [self.view addSubview:self.moviePlayer.view];
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.view bringSubviewToFront:self.backBtn];
    
}

-(IBAction)popView:(id)sender{
    [self.moviePlayer stop];
//    [self.moviePlayer.view removeFromSuperview];
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
