//
//  QuestionListController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionLibraryItem.h"
#import "WebRequest.h"
#import "ActionView.h"
@interface QuestionListController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(strong,nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong,nonatomic) UINib *nib;

@property(strong,nonatomic) NSMutableArray *dataAry;

@property(strong,nonatomic) NSMutableArray *answerAry;

/**
 *  0:考前练习default 1:考试记录 2:我的收藏 3:我的错题 4:随机练习 5:顺序练习 6:章节练习 7:未做题练习 8:考前模拟
 */
@property(nonatomic) NSInteger type;

/*
 *  章节信息
 1 道路交通安全法
 2 道路交通信号
 3 行车安全、文明驾驶
 4 机动车驾驶操作基础知识
 5 科目四违法的案例分析
 6 科目四安全行车常识
 7 科目四 常见交通标志、标线和交通手势辨识
 8 科目四驾驶职业道德和文明驾驶常识
 9 科目四恶劣天气和复杂道路条件下驾驶常识
 10 科目四紧急情况下避险常识
 11 科目四交通事故救护及常见危化品处置常识
 12 货车专用题
 13 客车专用
 14 摩托车专用
 */
@property(strong,nonatomic) NSString *detailType;

@property(strong,nonatomic) IBOutlet UIView *bottomBar;

@property(strong,nonatomic) IBOutlet UIView *bottomBar2;

@property(strong,nonatomic) IBOutlet UILabel *pageIndexLb;

@property(strong,nonatomic) IBOutlet UILabel *pageIndexLb2;

@property(nonatomic) NSInteger currentIndex;

@property(strong,nonatomic) IBOutlet UIButton *collectIconBtn;

@property(strong,nonatomic) IBOutlet UIButton *collectIconBtn2;

@property(strong,nonatomic) IBOutlet UIButton *commitPageIconBtn;

@property(strong,nonatomic) IBOutlet UIButton *resultBtn;

@property(strong,nonatomic) IBOutlet UIButton *resultBtn2;

@property(strong,nonatomic) UILabel *timerLb;

@property(strong,nonatomic) NSTimer *timer;

@property(nonatomic) int totalTime;

@property(nonatomic) int wrongCount;

@property(strong,nonatomic) IBOutlet UILabel *wrongCountLb;

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) ActionView *actionView;

@property(strong,nonatomic) UICollectionView *resultCollectionView;

@property(strong,nonatomic) UIView *resultCollectionBgView;

@property(strong,nonatomic) UINib *nib2;

@property(strong,nonatomic) IBOutlet UILabel *resultCurrectCountLb;
@property(strong,nonatomic) IBOutlet UILabel *resultWrongCountLb;
@property(strong,nonatomic) IBOutlet UILabel *resultNodoCountLb;

@property(strong,nonatomic) IBOutlet UIView *resultHeaderView;

@property(strong,nonatomic) IBOutlet UIButton *closeBtn;

-(void)didQuestionFinished:(QuestionLibraryItem *)item;


@end
