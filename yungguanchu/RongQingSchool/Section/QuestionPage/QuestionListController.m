//
//  QuestionListController.m
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "QuestionListController.h"
#import "QuestionCell.h"
#import "QuestionLibraryDao.h"
#import "FLAnimatedImage.h"
#import "QuestionLibraryItem.h"
#import "QuestionAnswerItem.h"
#import "UIButton+EnlargeArea.h"
#import "UIAlertView+XY.h"
#import "ExamRecordModel.h"
#import "ExamRecordDao.h"
#import "TabBarViewController.h"
#import "ExamResultCell.h"
//改库后的类
#import "NewQuestionLibraryDao.h"
#import "QuestionItem.h"
@interface QuestionListController ()

@end

@implementation QuestionListController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.navigationItem.leftBarButtonItems = [self getNewBackButtons];
    
    
    self.nib = [UINib nibWithNibName:@"QuestionCell" bundle:nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, UISCREEN_SIZE.height-KTOP_HEIGHT-self.bottomBar.frame.size.height) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.layer.cornerRadius = 3;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:self.nib forCellWithReuseIdentifier:@"cellid"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    self.answerAry = [NSMutableArray arrayWithCapacity:20];
    
    
    self.resultCollectionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabBarController.view.frame.size.height, UISCREEN_SIZE.width, 400)];
    self.resultCollectionBgView.backgroundColor = [UIColor whiteColor];
    
    CGRect r = self.resultHeaderView.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = UISCREEN_SIZE.width;
    self.resultHeaderView.frame = r;
    [self.resultCollectionBgView addSubview:self.resultHeaderView];
    
    r = self.closeBtn.frame;
    r.origin.x = UISCREEN_SIZE.width - 40;
    self.closeBtn.frame = r;
    
    self.nib2 = [UINib nibWithNibName:@"ExamResultCell" bundle:nil];
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.resultCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, UISCREEN_SIZE.width, 355) collectionViewLayout:layout2];
    self.resultCollectionView.dataSource = self;
    self.resultCollectionView.delegate = self;
    self.resultCollectionView.layer.cornerRadius = 3;
    self.resultCollectionView.layer.masksToBounds = YES;
    [self.resultCollectionView registerNib:self.nib2 forCellWithReuseIdentifier:@"cellid"];
    self.resultCollectionView.backgroundColor = [UIColor clearColor];
    [self.resultCollectionBgView addSubview:self.resultCollectionView];
    
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //考前练习 || 模拟考试
        if(self.type == 0 || self.type == 8){
            NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
            [dao openDataBase];
            if([UserInfo shareUserInfo].KemuTag == 1){
                self.dataAry = [Utils randomizedArray:[dao selectpageByCarType:[UserInfo shareUserInfo].userCarType]];
            }
            else{
                self.dataAry = [Utils randomizedArray:[dao selectpageByCarType:KeMu2]];
            }
            [dao closeDataBase];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bottomBar.hidden = NO;
                self.bottomBar2.hidden = YES;
            });
            
        }
        //我的收藏
        else if(self.type == 2){
            
            if([@"0" isEqualToString:self.detailType]){
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                self.dataAry = [dao selectCollectedQuestion];
                [dao closeDataBase];
            }
            else{
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                self.dataAry = [dao selectCollectedQuestionByDetail_type:[self.detailType intValue]];
                [dao closeDataBase];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bottomBar.hidden = YES;
                self.bottomBar2.hidden = NO;
            });

            
        }
        //我的错题
        else if(self.type == 3){
            
            if([@"0" isEqualToString:self.detailType]){
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                self.dataAry = [dao selectWrongQuestion];
                [dao closeDataBase];
            }
            else{
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                self.dataAry = [dao selectWrongQuestionByDetail:[self.detailType intValue]];
                [dao closeDataBase];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bottomBar.hidden = YES;
                self.bottomBar2.hidden = NO;
            });
            
        }
        //随机练习 || 顺序练习
        else if(self.type == 4 || self.type == 5){
            BOOL order = self.type == 4?NO:YES;
            [self selectKemuAll:order];
        }
        //章节练习
        else if(self.type == 6){
            if([@"0" isEqualToString:self.detailType]){
                [self selectKemuAll:YES];
            }
            else{
                [self selectKemuAndDetailType:self.detailType];
            }
        }
        //未做练习题
        else if(self.type == 7){
            
            if([@"0" isEqualToString:self.detailType]){
                
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                if([UserInfo shareUserInfo].KemuTag == 1){
                    self.dataAry = [dao selectNeverDoQuestion:[UserInfo shareUserInfo].userCarType];
                }
                else{
                    self.dataAry = [dao selectNeverDoQuestion:KeMu2];
                }
                
                [dao closeDataBase];
            }
            else{
                NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
                [dao openDataBase];
                self.dataAry = [dao selectNeverDoQuestionByDetail:self.detailType];
                [dao closeDataBase];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bottomBar.hidden = YES;
                self.bottomBar2.hidden = NO;
            });
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [Utils removeProgressHUB:self.view];
            
            _currentIndex = 0;
            self.pageIndexLb.text = [NSString stringWithFormat:@"%ld/%ld",(long)(_currentIndex+1),self.dataAry.count];
            self.pageIndexLb2.text = [NSString stringWithFormat:@"%ld/%ld",(long)(_currentIndex+1),self.dataAry.count];
            
            if(!self.dataAry.count) return;
            QuestionItem *item = self.dataAry[_currentIndex];
            [self.collectIconBtn setBackgroundImage:[UIImage imageNamed:
                                                     [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                           forState:UIControlStateNormal];
            [self.collectIconBtn2 setBackgroundImage:[UIImage imageNamed:
                                                     [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                           forState:UIControlStateNormal];
        });
    });
    
    [self.collectIconBtn setEnlargeEdgeWithTop:20 right:5 bottom:20 left:20];
    [self.collectIconBtn2 setEnlargeEdgeWithTop:20 right:5 bottom:20 left:20];
    [self.commitPageIconBtn setEnlargeEdgeWithTop:20 right:5 bottom:20 left:20];
    [self.resultBtn setEnlargeEdgeWithTop:20 right:5 bottom:20 left:20];
    [self.resultBtn2 setEnlargeEdgeWithTop:20 right:5 bottom:20 left:20];
    
    if(self.type == 0 || self.type == 8){
        self.navigationItem.rightBarButtonItems = [self getNewRightItem];
        
        _totalTime = 45*60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//        [self.timer fire];
    }
    
    self.actionView = [[[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:self options:nil] lastObject];
    self.actionView.titleLb.text = @"确定交卷吗？";
    [self.actionView.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.actionView.frame = CGRectMake(0, UISCREEN_SIZE.height, UISCREEN_SIZE.width, self.actionView.frame.size.height);
    __weak typeof(self) weakSelf = self;
    [self.actionView addClickBlock:^(NSInteger index) {
        if(index==0){
            [weakSelf actionClick:nil];
        }
        else{
            [weakSelf actionClick:nil];
            [weakSelf alertBack:nil];
        }
    }];
    
}

//查询科目所有，order是否有序
-(void)selectKemuAll:(BOOL)order{
    NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
    [dao openDataBase];
    if([UserInfo shareUserInfo].KemuTag == 1){
        self.dataAry = [dao selectAll:[UserInfo shareUserInfo].userCarType byOrder:order];
    }
    else{
        self.dataAry = [dao selectAll:KeMu2 byOrder:order];
    }
    [dao closeDataBase];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bottomBar.hidden = YES;
        self.bottomBar2.hidden = NO;
    });
}

//按章节查询，章节所有（所有detail_type一样的）
-(void)selectKemuAndDetailType:(NSString *)detailType{
    NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
    [dao openDataBase];
    self.dataAry = [dao selectKemuAndDetailType:self.detailType];
    [dao closeDataBase];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bottomBar.hidden = YES;
        self.bottomBar2.hidden = NO;
    });
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cellid";
    if(collectionView == self.collectionView){
        QuestionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.backgroundColor = MAIN_VIEW_COLOR;
        
        QuestionItem *questionItem = self.dataAry[indexPath.row];
        cell.questionItem = questionItem;
        
        cell.resultLb22.text = [NSString stringWithFormat:@"%d",questionItem.sortId];
        
        //    cell
        
        //问题描述
        [Utils autoHeightLabel2:cell.questionTextLb
                     withString:questionItem.questionStr
                       setFrame:CGRectMake(cell.questionTextLb.frame.origin.x,
                                           cell.questionTextLb.frame.origin.y,
                                           UISCREEN_SIZE.width-60,
                                           1000)
                           font:cell.questionTextLb.font];
        
        NSString *imagePath = questionItem.image_path;
        NSString *gifPath = questionItem.flash_path;
        
        CGRect originFrame = cell.animatedImageView.frame;
        originFrame.origin.x = 3;
        originFrame.origin.y = CGRectGetMaxY(cell.questionTextLb.frame)+7;
        originFrame.size.width = cell.questionTextLbBgView.frame.size.width - 6;
        originFrame.size.height = 166;
        cell.animatedImageView.frame = originFrame;
        
        if(![Utils isNullOrEmpty:imagePath]){
            [cell.player pause];
            cell.playerView.hidden = YES;
            
            NSArray *ary =  [imagePath componentsSeparatedByString:@"/"];
            NSString *imageName = [ary lastObject];
            //        CLog(@"%@",imageName);
            
            cell.animatedImageView.image = [UIImage imageNamed:imageName];
            [self autoSizeAnimatiImageView:cell.animatedImageView.image.size animateImageView:cell.animatedImageView];
            
        }
        else if(![Utils isNullOrEmpty:gifPath]){
            
            /* gif播放动图
             NSURL *url1 = [[NSBundle mainBundle] URLForResource:gifPath withExtension:@""];
             NSData *data1 = [NSData dataWithContentsOfURL:url1];
             FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
             cell.animatedImageView.animatedImage = animatedImage1;
             [self autoSizeAnimatiImageView:animatedImage1.size animateImageView:cell.animatedImageView];
             */
            
            //AVPlayer 播放视频
            cell.playerView.hidden = NO;
            cell.playerView.frame = CGRectMake(3,
                                               CGRectGetMaxY(cell.questionTextLb.frame)+7,
                                               cell.questionTextLbBgView.frame.size.width - 6,
                                               (cell.questionTextLbBgView.frame.size.width - 6)/2.25);
            [cell.questionTextLbBgView bringSubviewToFront:cell.playerView];
            [cell vedioPlay:gifPath];
            
            cell.animatedImageView.image = [UIImage imageNamed:@"huoche-22.jpg"];//默认设置一个图片
            [cell.questionTextLbBgView bringSubviewToFront:cell.playerView];
            cell.animatedImageView.frame = cell.playerView.frame;
        }
        else{
            //        cell.animatedImageView.animatedImage = nil;
            [cell.player pause];
            cell.playerView.hidden = YES;
            cell.animatedImageView.image = [UIImage imageNamed:@"huoche-22.jpg"];
            cell.animatedImageView.frame = CGRectMake(0, CGRectGetMaxY(cell.questionTextLb.frame), 0, 0);
        }
        
        cell.questionTextLbBgView.frame = CGRectMake(cell.questionTextLbBgView.frame.origin.x,
                                                     cell.questionTextLbBgView.frame.origin.y,
                                                     cell.questionTextLbBgView.frame.size.width,
                                                     CGRectGetMaxY(cell.animatedImageView.frame)+CGRectGetMinY(cell.questionTextLb.frame));
        int k=-1;
        if (questionItem.subType==1) {
            k=2;
        }
        if (questionItem.subType==2) {
            k=0;
        }
        if (questionItem.subType==3) {
            k=1;
        }
        
        cell.optionTypeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"option_type_%d",k]];
        
        NSMutableArray *answer;
        if(indexPath.row >= self.answerAry.count){
            NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
            [dao openDataBase];
            answer = [dao selectAnswer:questionItem];
            [dao closeDataBase];
            [self.answerAry addObject:answer];
        }
        else{
            answer = self.answerAry[indexPath.row];
        }
        
        /*
         NSMutableArray *answer = [self.answerAry objectAtIndex:indexPath.row];
         */
        
        NSArray *answer2 = [answer sortedArrayUsingComparator:
                            ^NSComparisonResult(QuestionAnswerItem *obj1, QuestionAnswerItem *obj2) {
                                // 排序
                                NSComparisonResult result = [obj1.answer compare:obj2.answer];
                                
                                return result;
                            }];
        
        cell.dataAry = answer;
        [cell.tableView reloadData];
        CGRect r = CGRectMake(10, CGRectGetMaxY(cell.questionTextLbBgView.frame)+10, cell.tableView.frame.size.width, cell.tableView.contentSize.height);
        cell.tableView.frame = r;
        //    CLog(@"%f",cell.tableView.contentSize.height);
        
        r = CGRectMake(10, CGRectGetMaxY(cell.tableView.frame)+10, 300, 21);
        cell.resultLb.frame = r;
        if(questionItem.optionStatus == -1){
            cell.resultLb.text = @"请选择";
        }
        else if(questionItem.optionStatus == 1){
            cell.resultLb.text = @"答对了😄";
        }
        else{
            cell.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",questionItem.answer];
        }
        
        //多选提交按钮
        cell.commitBtn.hidden = !(questionItem.subType == 3);
        r = cell.commitBtn.frame;
        r.origin.y = CGRectGetMinY(cell.resultLb.frame);
        cell.commitBtn.frame = r;
        cell.commitBtn.tag = indexPath.row;
        
        CGSize contentSize = cell.bgScrollView.frame.size;
        if(cell.commitBtn.hidden){
            contentSize.height = MAX(CGRectGetMaxY(cell.resultLb.frame)+25, CGRectGetHeight(cell.bgScrollView.frame)) ;
        }
        else{
            contentSize.height = MAX(CGRectGetMaxY(cell.commitBtn.frame)+25, CGRectGetHeight(cell.bgScrollView.frame)) ;
        }
        
        cell.bgScrollView.contentSize = contentSize;
        
        return cell;
    }
    else{
        ExamResultCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        QuestionItem *questionItem = self.dataAry[indexPath.row];
        if(questionItem.optionStatus == 1){
            cell.headPic.image = [UIImage imageNamed:@"currect_bottom"];
            cell.lb.textColor = [UIColor whiteColor];
        }
        else if(questionItem.optionStatus == 0){
            cell.headPic.image = [UIImage imageNamed:@"wrong_bottom"];
            cell.lb.textColor = [UIColor whiteColor];
        }
        else{
            cell.headPic.image = [UIImage imageNamed:@"nodo_bottom"];
            cell.lb.textColor = UIColorFromRGB(102, 102, 102);
        }
        cell.lb.text = NSStringFromInt(indexPath.row+1);
        return cell;
    }
    
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.collectionView){
        return CGSizeMake(UISCREEN_SIZE.width, UISCREEN_SIZE.height-KTOP_HEIGHT-self.bottomBar.frame.size.height);
    }
    else{
        return CGSizeMake(42, 42);
    }
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(collectionView == self.collectionView){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else{
        return UIEdgeInsetsMake(0, 5, 5, 5);
    }
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat jx=0.0f;
    return jx;
}

//自适应图片大小
-(void)autoSizeAnimatiImageView:(CGSize)imageSize animateImageView:(UIImageView *)animateImageView{
    CGRect r = animateImageView.frame;
    if(imageSize.width > r.size.width){
        CGFloat scale = r.size.width/imageSize.width;
        r.size.width = imageSize.width*scale;
        r.size.height = imageSize.height*scale;
        
    }
    else{
        r.size.width = imageSize.width;
        r.size.height = imageSize.height;
    }
//    CLog(@"%f,%f",imageSize.width,imageSize.height);
    animateImageView.frame = r;
}

#pragma mark - scroll view delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollviewEndScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollviewEndScroll:scrollView];
}

-(void)scrollviewEndScroll:(UIScrollView *)scrollView{
    _currentIndex = scrollView.contentOffset.x/scrollView.frame.size.width;;
    self.pageIndexLb.text = [NSString stringWithFormat:@"%ld/%ld",(long)(_currentIndex+1),self.dataAry.count];
    self.pageIndexLb2.text = [NSString stringWithFormat:@"%ld/%ld",(long)(_currentIndex+1),self.dataAry.count];
    
    QuestionItem *item = self.dataAry[_currentIndex];
    [self.collectIconBtn setBackgroundImage:[UIImage imageNamed:
                                             [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                   forState:UIControlStateNormal];
    [self.collectIconBtn2 setBackgroundImage:[UIImage imageNamed:
                                              [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                    forState:UIControlStateNormal];
}

-(IBAction)colletQuestion:(id)sender{
    QuestionItem *item = self.dataAry[_currentIndex];
    item.collect_flag = 1-item.collect_flag;
    [self.collectIconBtn setBackgroundImage:[UIImage imageNamed:
                                             [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                   forState:UIControlStateNormal];
    [self.collectIconBtn2 setBackgroundImage:[UIImage imageNamed:
                                             [NSString stringWithFormat:@"bottom_collection_%d",item.collect_flag]]
                                   forState:UIControlStateNormal];
    NewQuestionLibraryDao *dao = [[NewQuestionLibraryDao alloc] init];
    [dao openDataBase];
    [dao collectQuestion:item];
    [dao closeDataBase];
    
    
}

-(IBAction)commitTestPage:(id)sender{
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定提交吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
        if(btnIndex == 1){
            [self alertBack:alert];
        }
    }];
     */
    
    [self showAction:nil];
}

-(void)didQuestionFinished:(QuestionItem *)item{
    if(!item.optionStatus){
        self.wrongCount ++;
        self.wrongCountLb.text = [NSString stringWithFormat:@"已错%d题",self.wrongCount];
    }
    
    //自动翻页
    if(self.type == 0 || self.type == 8){
        dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
        dispatch_after(t, dispatch_get_main_queue(), ^{
            CGFloat offX = self.collectionView.contentOffset.x;
            if(offX < self.collectionView.contentSize.width-self.collectionView.frame.size.width){
                offX += self.collectionView.frame.size.width;
                [self.collectionView setContentOffset:CGPointMake(offX, 0) animated:YES];
            }
        });
    }
}

//提交模拟考试成绩
-(void)commitExam:(int)score date:(NSString *)date :(void (^)(BOOL finished))completion{
    
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid",
                               [UserInfo shareUserInfo].KemuTag == 1? NSStringFromInt(score):NSStringFromInt(score*2),@"simscore",
                               date,@"simtime",nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_Simulation WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"examCommitSuccess"];
        
        completion(YES);
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        completion(NO);
    }];
}

-(void)alertBack:(UIAlertView *)alert{
    int score = 0;
    for(QuestionItem *item in self.dataAry){
        if(item.optionStatus == 1){
            score ++;
        }
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy.MM.dd hh:mm";
    NSString *dateStr = [df stringFromDate:date];
    
    if(self.type == 0){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveExamToDatabase:score date:dateStr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        });
    }
    else{
        [self commitExam:score date:dateStr :^(BOOL finished) {
            if(finished){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self saveExamToDatabase:score date:dateStr];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                    
                });
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
}

//保存考试记录到数据库，,只有type=0||8的时候才有调用
-(void)saveExamToDatabase:(int)score date:(NSString *)dateStr{
    
    
    
    ExamRecordModel *item = [[ExamRecordModel alloc] init];
    item.score = [UserInfo shareUserInfo].KemuTag == 1? NSStringFromInt(score):NSStringFromInt(score*2);
    item.userID = [UserInfo shareUserInfo].uId;
    item.time = self.timerLb.text;
    item.date = dateStr;
    
    if([UserInfo shareUserInfo].KemuTag == 1){
        item.subject_type = [UserInfo shareUserInfo].userCarType;
    }
    else{
        item.subject_type = KeMu2;
    }
    
    ExamRecordDao *dao = [[ExamRecordDao alloc] init];
    [dao openDataBase];
    [dao insertExamRecord:item];
    [dao closeDataBase];
    
    
}

//显示确认action
-(IBAction)showAction:(UIButton *)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.actionView];
    [tabbarVc.view bringSubviewToFront:self.actionView];
    
    tabbarVc.grayBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.actionView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.actionView.frame = r;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(IBAction)showResultCollectionView{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    [self.tabBarController.view addSubview:self.resultCollectionBgView];
    [tabbarVc.view bringSubviewToFront:self.resultCollectionBgView];
    [self.resultCollectionView reloadData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger currect = 0;
        NSInteger wrong = 0;
        NSInteger nodo = 0;
        for(QuestionItem *item in self.dataAry){
            if(item.optionStatus == 1){
                currect ++;
            }
            else if(item.optionStatus == 0){
                wrong ++;
            }
            else{
                nodo ++;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultCurrectCountLb.text = NSStringFromInt(currect);
            self.resultWrongCountLb.text = NSStringFromInt(wrong);
            self.resultNodoCountLb.text = NSStringFromInt(nodo);
        });
    });
    tabbarVc.grayBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.resultCollectionBgView.frame;
        r.origin.y = tabbarVc.view.frame.size.height-r.size.height;
        
        self.resultCollectionBgView.frame = r;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(IBAction)hideResultCollectioView{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.resultCollectionBgView.frame;
        r.origin.y = self.tabBarController.view.frame.size.height;
        
        self.resultCollectionBgView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.resultCollectionBgView removeFromSuperview];
    }];
}

//隐藏确认action
-(IBAction)actionClick:(id)sender{
    TabBarViewController *tabbarVc = (TabBarViewController *)self.tabBarController;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.actionView.frame;
        r.origin.y = UISCREEN_SIZE.height;
        
        self.actionView.frame = r;
        
    } completion:^(BOOL finished) {
        tabbarVc.grayBtn.hidden = YES;
        [self.actionView removeFromSuperview];
    }];
}


-(void)time:(NSTimer *)timer{
    self.totalTime --;
    int minute = self.totalTime/60;
    int second = self.totalTime%60;
    self.timerLb.text = [NSString stringWithFormat:@"%d:%d",minute,second];
    if(self.totalTime<=0){
        [self.timer invalidate];
        self.actionView.titleLb.text = @"时间已到，请教卷";
        [self.actionView.leftBtn setTitle:@"" forState:UIControlStateNormal];
        [self.actionView.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self showAction:nil];
    }
}

-(void)popview:(id)sender{
    if(self.type == 0 || self.type == 8){
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定返回并提交试卷吗？" delegate:self cancelButtonTitle:@"不返回" otherButtonTitles:@"返回并提交", nil];
        [alert show];
        [alert uxy_handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
            if(btnIndex == 1){
                [self alertBack:alert];
            }
        }];
         */
        
        [self showAction:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
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

-(NSArray*)getNewRightItem
{
    _timerLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    _timerLb.backgroundColor = [UIColor clearColor];
    _timerLb.textColor = [UIColor whiteColor];
    _timerLb.font = [UIFont systemFontOfSize:15];
    _timerLb.text = @"45:00";
    _timerLb.textAlignment = NSTextAlignmentRight;
    
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:_timerLb];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -0;
    else
        negativeSpacer.width = 0;
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
