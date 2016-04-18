//
//  HomeViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//
#import "MJZDListViewController.h"
#import "HomeViewController.h"
#import "TabBarViewController.h"
#import "QuestionLibraryDao.h"
#import "QuestionListController.h"
#import "UINavigationController+NewBackButton.h"
#import "ExamRecordListController.h"
#import "StatisticsViewController.h"
#import "DetailTypeListController.h"
#import "MyMessagesListController.h"
#import "UIImageView+WebCache.h"
#import "VideoCell.h"
#import "VideoItem.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "VideoListViewController.h"
#import "VideoDetailViewController.h"
#import "ArticleViewController.h"
#import "FileUtil.h"
extern BOOL isMainViewDisplaying;

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"阳都驾校";
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    
    if([UserInfo shareUserInfo].isLogin){
        self.navigationItem.rightBarButtonItems = [self getRightButtons];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:Notification_Login_Success object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess) name:Notification_Logout_Success object:nil];
    
    [self initView];
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
    
    self.navigationController.delegate = self;
    
    //获取启动图片
    CGSize viewSize = UISCREEN_SIZE;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    self.launchImageView.image = [UIImage imageNamed:launchImage];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.tabBar bringSubviewToFront:tabbarVc.tabbarBgView];
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
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    self.bgScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, 357);
    
    self.bgView2.hidden = YES;
    self.bgView3.hidden = YES;
    self.bgScrollView.hidden = NO;

    /*
    //顶端广告
    self.adScrollView = [[ADScrollView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 117) animationDuration:5];
    self.adScrollView.delegate = self;
    self.adScrollView.dataSource = self;
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:self.adScrollView];
     */
    self.adScroll.contentSize = CGSizeMake(UISCREEN_SIZE.width*2, self.adScroll.frame.size.height);
    [self.adPic1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IP,@"01.png"]] placeholderImage:[UIImage imageNamed:@"scroll_ad_00"] options:SDWebImageRefreshCached];
    [self.adPic2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IP,@"02.png"]] placeholderImage:[UIImage imageNamed:@"scroll_ad_01"] options:SDWebImageRefreshCached];
    self.adPic2.frame = CGRectMake(UISCREEN_SIZE.width, 0, UISCREEN_SIZE.width, self.adPic2.frame.size.height);
    self.adScroll.pagingEnabled = YES;
    self.adScroll.showsHorizontalScrollIndicator = NO;
    self.adScroll.bounces = NO;
    
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.636 blue:0.175 alpha:1.000];
    
    self.nib0 = [UINib nibWithNibName:@"VideoCell" bundle:nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView0 = [[UICollectionView alloc] initWithFrame:
                            CGRectMake(0,
                                       self.collectionHeader0.frame.size.height,
                                       UISCREEN_SIZE.width,
                                       UISCREEN_SIZE.height-self.contentBarView.frame.size.height-KTOP_HEIGHT-49-self.collectionHeader0.frame.size.height)
                                              collectionViewLayout:layout];
    self.collectionView0.dataSource = self;
    self.collectionView0.delegate = self;
    self.collectionView0.backgroundColor = [UIColor whiteColor];
    [self.collectionView0 registerNib:self.nib0 forCellWithReuseIdentifier:@"cellid0"];
    self.collectionView0.alwaysBounceVertical = YES;
    self.collectionView0.bounces = YES;
    [self.bgView2 addSubview:self.collectionView0];
    
    self.nib1 = [UINib nibWithNibName:@"VideoCell" bundle:nil];
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView1 = [[UICollectionView alloc] initWithFrame:
                            CGRectMake(0,
                                       self.collectionHeader1.frame.size.height,
                                       UISCREEN_SIZE.width,
                                       UISCREEN_SIZE.height-self.contentBarView.frame.size.height-KTOP_HEIGHT-49-self.collectionHeader1.frame.size.height)
                                              collectionViewLayout:layout1];
    self.collectionView1.dataSource = self;
    self.collectionView1.delegate = self;
    self.collectionView1.backgroundColor = [UIColor whiteColor];
    [self.collectionView1 registerNib:self.nib1 forCellWithReuseIdentifier:@"cellid0"];
    self.collectionView1.alwaysBounceVertical = YES;
    self.collectionView1.bounces = YES;
    [self.bgView3 addSubview:self.collectionView1];
    
    [self layoutContentView];
    
//    self.contentBarView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.contentBarView.layer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.contentBarView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
//    self.contentBarView.layer.shadowRadius = 4;//阴影半径，默认3
    [self.view bringSubviewToFront:self.contentBarView];
    
}

-(void)layoutContentView{
    
    CGRect r = self.adScroll.frame;
    r.size.height *= WIDTH_SCALE;
    self.adScroll.frame = r;
    self.adPic1.frame = CGRectMake(0, 0, UISCREEN_SIZE.width, r.size.height);
    self.adPic2.frame = CGRectMake(UISCREEN_SIZE.width, 0, UISCREEN_SIZE.width, r.size.height);
    
    r = self.contentView1.frame;
    r.origin.y = self.adScroll.frame.size.height;
    r.size.width *= WIDTH_SCALE;
    r.size.height *= WIDTH_SCALE;
    self.contentView1.frame = r;
    
    for(UIView *vv in self.contentView1.subviews){
        CGRect rr = vv.frame;
        rr.origin.x *= WIDTH_SCALE;
        rr.origin.y *= WIDTH_SCALE;
        rr.size.width *= WIDTH_SCALE;
        rr.size.height *= WIDTH_SCALE;
        
        vv.frame = rr;
        
//        for(UIView *vvv in vv.subviews){
//            CGRect rrr = vvv.frame;
//            rrr.origin.x *= WIDTH_SCALE;
//            rrr.origin.y *= WIDTH_SCALE;
//            rrr.size.width *= WIDTH_SCALE;
//            rrr.size.height *= WIDTH_SCALE;
//            
//            vvv.frame = rrr;
//        }
    }
    
    CGFloat scale = (UISCREEN_SIZE.height-KTOP_HEIGHT-49-self.contentBarView.frame.size.height) / CGRectGetMaxY(self.contentView1.frame);
    self.contentView1.clipsToBounds = YES;
    r = self.adScroll.frame;
    r.size.height *= scale;
    self.adScroll.frame = r;
    self.adPic1.frame = CGRectMake(0, 0, UISCREEN_SIZE.width, r.size.height);
    self.adPic2.frame = CGRectMake(UISCREEN_SIZE.width, 0, UISCREEN_SIZE.width, r.size.height);
    
    r = self.pageControl.frame;
    r.origin.y = self.adScroll.frame.size.height-30;
    self.pageControl.frame = r;
    
    r = self.contentView1.frame;
    r.origin.y = self.adScroll.frame.size.height;
    r.size.height *= scale;
    self.contentView1.frame = r;
//    self.contentView1.backgroundColor = [UIColor blueColor];

    for(UIView *v in self.contentView1.subviews){
//        v.center = CGPointMake(v.center.x, v.center.y*scale);
        CGRect rrr = v.frame;
        rrr.origin.y *= scale;
        rrr.size.height *= scale;
        v.frame = rrr;
        
        for(UIView *vv in v.subviews){
            if([vv isMemberOfClass:[UIView class]]){
                vv.center = CGPointMake(vv.superview.frame.size.width/2, vv.center.y*scale*WIDTH_SCALE);
//                CGRect rrrr = vv.frame;
//                rrrr.origin.x *= scale;
//                rrrr.origin.y *= scale;
//                vv.frame = rrrr;
            }
            else{
                CGRect rrrr = vv.frame;
                rrrr.origin.y *= scale;
                rrrr.size.height *= (scale*WIDTH_SCALE);
                rrrr.size.width *= (scale*WIDTH_SCALE);
                vv.frame = rrrr;
            }
        }
        
    }
    self.bgScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, CGRectGetMaxY(self.contentView1.frame));
    CLog(@"%f",CGRectGetMaxY(self.contentView1.frame))
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_SIZE.width/2, 0, 0.5, self.contentView1.frame.size.height)];
    v1.backgroundColor = UIColorFromRGB(210, 210, 210);
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_SIZE.width/4*3, 0, 0.5, self.contentView1.frame.size.height)];
    v2.backgroundColor = UIColorFromRGB(210, 210, 210);
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_SIZE.width/4, self.contentView1.frame.size.height/3*2, 0.5, self.contentView1.frame.size.height/3)];
    v3.backgroundColor = UIColorFromRGB(210, 210, 210);
    
    UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_SIZE.width/2, self.contentView1.frame.size.height/3, UISCREEN_SIZE.width, 0.5)];
    v4.backgroundColor = UIColorFromRGB(210, 210, 210);
    
    UIView *v5 = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView1.frame.size.height/3*2, UISCREEN_SIZE.width, 0.5)];
    v5.backgroundColor = UIColorFromRGB(210, 210, 210);
    
    r = self.v0.frame;
    r.origin.x = (UISCREEN_SIZE.width/4-r.size.width)/2;
    self.v0.frame = r;
    
    r = self.v1.frame;
    r.origin.x = (UISCREEN_SIZE.width/4-r.size.width)/2 + UISCREEN_SIZE.width/4;
    self.v1.frame = r;
    
    r = self.v2.frame;
    r.origin.x = (UISCREEN_SIZE.width/4-r.size.width)/2 + UISCREEN_SIZE.width/2;
    self.v2.frame = r;
    
    r = self.v3.frame;
    r.origin.x = (UISCREEN_SIZE.width/4-r.size.width)/2 + UISCREEN_SIZE.width/4*3;
    self.v3.frame = r;
    
    
    
    [self.contentView1 addSubview:v1];
    [self.contentView1 addSubview:v2];
    [self.contentView1 addSubview:v3];
    [self.contentView1 addSubview:v4];
    [self.contentView1 addSubview:v5];
    
    self.contentView1.layer.borderColor = UIColorFromRGB(210, 210, 210).CGColor;
    self.contentView1.layer.borderWidth = 0.5;
}

-(IBAction)changeContentView:(UIButton *)sender{
    sender.selected = YES;
    if(sender == self.kemu1Btn){
        self.kemu2Btn.selected = NO;
        self.kemu3Btn.selected = NO;
        self.kemu4Btn.selected = NO;
        
        self.kemu1Lb.textColor = UIColorFromRGB(3, 180, 248);
        self.kemu1leftImageView.image = [UIImage imageNamed:@"kemu1_select"];
        
        self.kemu2Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu2leftImageView.image = [UIImage imageNamed:@"kemu2_unselect"];
        
        self.kemu3Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu3leftImageView.image = [UIImage imageNamed:@"kemu3_unselect"];
        
        self.kemu4Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu4leftImageView.image = [UIImage imageNamed:@"kemu4_unselect"];
        
        [UserInfo shareUserInfo].KemuTag = 1;
        
        self.bgView2.hidden = YES;
        self.bgView3.hidden = YES;
        self.bgScrollView.hidden = NO;
    }
    else if(sender == self.kemu2Btn){
        self.kemu1Btn.selected = NO;
        self.kemu3Btn.selected = NO;
        self.kemu4Btn.selected = NO;
        
        self.kemu1Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu1leftImageView.image = [UIImage imageNamed:@"kemu1_unselect"];
        
        self.kemu2Lb.textColor = UIColorFromRGB(3, 180, 248);
        self.kemu2leftImageView.image = [UIImage imageNamed:@"kemu2_select"];
        
        self.kemu3Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu3leftImageView.image = [UIImage imageNamed:@"kemu3_unselect"];
        
        self.kemu4Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu4leftImageView.image = [UIImage imageNamed:@"kemu4_unselect"];
        
        [UserInfo shareUserInfo].KemuTag = 1;
        
        self.bgView2.hidden = NO;
        self.bgView3.hidden = YES;
        self.bgScrollView.hidden = YES;
        
        
        if(!_isLoadVideo0){
            [self requestVideo0:@"0" isIndex:@"0"];
        }
    }
    else if(sender == self.kemu3Btn){
        self.kemu1Btn.selected = NO;
        self.kemu2Btn.selected = NO;
        self.kemu4Btn.selected = NO;
        
        self.kemu1Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu1leftImageView.image = [UIImage imageNamed:@"kemu1_unselect"];
        
        self.kemu2Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu2leftImageView.image = [UIImage imageNamed:@"kemu2_unselect"];
        
        self.kemu3Lb.textColor = UIColorFromRGB(3, 180, 248);
        self.kemu3leftImageView.image = [UIImage imageNamed:@"kemu3_select"];
        
        self.kemu4Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu4leftImageView.image = [UIImage imageNamed:@"kemu4_unselect"];
        
        [UserInfo shareUserInfo].KemuTag = 1;
        
        self.bgView2.hidden = YES;
        self.bgView3.hidden = NO;
        self.bgScrollView.hidden = YES;
        
        if(!_isLoadVideo1){
            [self requestVideo1:@"1" isIndex:@"0"];
        }
    }
    else{
        self.kemu1Btn.selected = NO;
        self.kemu2Btn.selected = NO;
        self.kemu3Btn.selected = NO;
        
        self.kemu1Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu1leftImageView.image = [UIImage imageNamed:@"kemu1_unselect"];
        
        self.kemu2Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu2leftImageView.image = [UIImage imageNamed:@"kemu2_unselect"];
        
        self.kemu3Lb.textColor = UIColorFromRGB(105, 103, 104);
        self.kemu3leftImageView.image = [UIImage imageNamed:@"kemu3_unselect"];
        
        self.kemu4Lb.textColor = UIColorFromRGB(3, 180, 248);
        self.kemu4leftImageView.image = [UIImage imageNamed:@"kemu4_select"];
        
        [UserInfo shareUserInfo].KemuTag = 2;
        
        self.bgView2.hidden = YES;
        self.bgView3.hidden = YES;
        self.bgScrollView.hidden = NO;
    }
    [self.view bringSubviewToFront:self.contentBarView];
}

#pragma mark - ADScrollView delegate
//获取page个数
- (NSInteger)numberOfSectionsInADScrollView:(ADScrollView *)adScrollView{
    return 2;
}

//获取第index个page的contentView
- (UIView *)adScrollView:(ADScrollView *)adScrollView contentViewForSection:(NSInteger)index{
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, adScrollView.frame.size.width, adScrollView.frame.size.height)];
    NSString *s = [NSString stringWithFormat:@"scroll_ad_%02ld",(long)index];
    imageView1.image = [UIImage imageNamed:s];
    return imageView1;
}

//点击第index个page时的动作
- (void)adScrollView:(ADScrollView *)adScrollView didSelectSectionAtIndex:(NSInteger)index{
    
}

#pragma mark - scroll delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offX = scrollView.contentOffset.x;
    int index = offX/UISCREEN_SIZE.width;
    self.pageControl.currentPage = index;
}

#pragma mark -

//考前练习
-(IBAction)questionClick:(UIButton *)sender{
    QuestionListController *questionListController = [[QuestionListController alloc] init];
    questionListController.title = @"考前练习";
    [self.navigationController pushViewController:questionListController animated:YES];
}

//考试记录
-(IBAction)questionRecordClick:(id)sender{
    ExamRecordListController *examRecordListController = [[ExamRecordListController alloc] init];
    [self.navigationController pushViewController:examRecordListController animated:YES];
}

//我的收藏
-(IBAction)questionCollectionClick:(id)sender{
    DetailTypeListController *detailTypeListControlle = [[DetailTypeListController alloc] init];
    detailTypeListControlle.type = 2;
    detailTypeListControlle.title = @"我的收藏";
    [self.navigationController pushViewController:detailTypeListControlle animated:YES];
}

//我的错题
-(IBAction)wrongQuestionClick:(id)sender{
    DetailTypeListController *detailTypeListControlle = [[DetailTypeListController alloc] init];
    detailTypeListControlle.type = 3;
    detailTypeListControlle.title = @"我的错题";
    [self.navigationController pushViewController:detailTypeListControlle animated:YES];
}

//随机练习
-(IBAction)randomClick:(id)sender{
    QuestionListController *questionListController = [[QuestionListController alloc] init];
    questionListController.type = 4;
    questionListController.title = @"随机练习";
    [self.navigationController pushViewController:questionListController animated:YES];
}

//顺序练习
-(IBAction)orderClick:(id)sender{
    QuestionListController *questionListController = [[QuestionListController alloc] init];
    questionListController.type = 5;
    questionListController.title = @"顺序练习";
    [self.navigationController pushViewController:questionListController animated:YES];
}

//统计
-(IBAction)gotoStatistics:(id)sender{
    StatisticsViewController *statisticsViewController = [[StatisticsViewController alloc] init];
    [self.navigationController pushViewController:statisticsViewController animated:YES];
}

//章节练习
-(IBAction)gotoDetailTypeList:(id)sender{
    DetailTypeListController *detailTypeListControlle = [[DetailTypeListController alloc] init];
    detailTypeListControlle.type = 6;
    detailTypeListControlle.title = @"章节练习";
    [self.navigationController pushViewController:detailTypeListControlle animated:YES];
}

//未做练习题
-(IBAction)gotoNeverDoList:(id)sender{
    DetailTypeListController *detailTypeListControlle = [[DetailTypeListController alloc] init];
    detailTypeListControlle.type = 7;
    detailTypeListControlle.title = @"未做题练习";
    [self.navigationController pushViewController:detailTypeListControlle animated:YES];
}

//显示左菜单
-(void)showLeftMenu:(id)sender{
    
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [tabbarVc.leftMenuController showLeftMenu];
    
}

//我的消息
-(void)gotoMessages{
    MyMessagesListController *myMessageViewController = [[MyMessagesListController alloc] init];
    [self.navigationController pushViewController:myMessageViewController animated:YES];
}

-(void)loginSuccess{
    if(!self.navigationItem.rightBarButtonItems){
        self.navigationItem.rightBarButtonItems = [self getRightButtons];
    }
}

-(void)logoutSuccess{
    self.navigationItem.rightBarButtonItems = nil;
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
    [Utils addProgressHUBInView:self.collectionView0 animation:@"activator.gif" delegate:nil];
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
        [self.collectionView0 reloadData];
        [Utils removeProgressHUB:self.collectionView0];
        
    } failedBlock:^(NSDictionary *resultDic) {
        self.isLoadVideo0 = NO;
        [Utils removeProgressHUB:self.collectionView0];
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
    [Utils addProgressHUBInView:self.collectionView1 animation:@"activator.gif" delegate:nil];
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
        [self.collectionView1 reloadData];
        [Utils removeProgressHUB:self.collectionView1];
        
    } failedBlock:^(NSDictionary *resultDic) {
        self.isLoadVideo1 = NO;
        [Utils removeProgressHUB:self.collectionView1];
    }];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if(collectionView == self.collectionView0){
        return self.videoAry0.count;
    }
    else if(collectionView == self.collectionView1){
        return self.videoAry1.count;
    }
    else{
        return 0;
    }
    
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cellid0";
    VideoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    VideoItem *item;
    if(collectionView == self.collectionView0){
        item = self.videoAry0[indexPath.row];
    }
    else{
        item = self.videoAry1[indexPath.row];
    }
    
    CGRect r = cell.titleLb.frame;
    r.size.height = 36;
    [Utils autoHeightLabel2:cell.titleLb withString:item.name setFrame:r font:[UIFont systemFontOfSize:15]];
    
    cell.videoBtn.layer.cornerRadius = 3;
    cell.videoBtn.layer.masksToBounds = YES;
    
    
    [cell.videoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:item.picUrl] forState:UIControlStateNormal];
//    cell.timeLb.text = item.videoUrl;
    return cell;
    
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoItem *item = self.videoAry0[indexPath.row];
    CGSize size = [item.name sizeWithFont:[UIFont systemFontOfSize:15]
                    constrainedToSize:CGSizeMake((UISCREEN_SIZE.width-30)/2,36)
                         lineBreakMode:NSLineBreakByWordWrapping];
    return CGSizeMake(UISCREEN_SIZE.width/2-15,120-18+size.height);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoItem *videoItem;
    if(collectionView == self.collectionView0){
        videoItem = self.videoAry0[indexPath.row];
    }
    else{
        videoItem = self.videoAry1[indexPath.row];
    }
    
    VideoDetailViewController *vd = [[VideoDetailViewController alloc] init];
    vd.videoItem = videoItem;
    [self.navigationController pushViewController:vd animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat jx=0.0f;
    return jx;
}

-(IBAction)gotoVideoDown:(UIButton *)sender{
    VideoListViewController *vd = [VideoListViewController shareInstance];
    vd.firstTag = (int)sender.tag;
    [self.navigationController pushViewController:vd animated:YES];
}

-(IBAction)gotoArticleDetail:(UIButton *)sender{
    ArticleViewController *articleViewControler = [[ArticleViewController alloc] init];
    articleViewControler.flag = sender.tag;
    [self.navigationController pushViewController:articleViewControler animated:YES];
}

-(IBAction)gotoMJZD:(id)sender{
    MJZDListViewController *mjzdListViewController = [[MJZDListViewController alloc] init];
    [self.navigationController pushViewController:mjzdListViewController animated:YES];
}

#pragma mark - navigation delegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController isKindOfClass:[VideoDetailViewController class]]){
        [navigationController setNavigationBarHidden:YES animated:animated];
    }
    else{
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
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

-(NSArray*)getRightButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(gotoMessages) forControlEvents:UIControlEventTouchUpInside];
    if([UserInfo shareUserInfo].msgCount.intValue){
        [backbtn setBackgroundImage:[UIImage imageNamed:@"icon_notic_new"] forState:UIControlStateNormal];
    }
    else{
        [backbtn setBackgroundImage:[UIImage imageNamed:@"icon_notic"] forState:UIControlStateNormal];
    }
    
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
