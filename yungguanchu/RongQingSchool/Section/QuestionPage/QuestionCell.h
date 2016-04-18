//
//  QuestionCell.h
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "QuestionLibraryItem.h"
#import "QuestionItem.h"
#import "QuestionListController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerView.h"

@interface QuestionCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>

//scroll view
@property(strong,nonatomic) IBOutlet UIScrollView *bgScrollView;

//问题描述
@property(strong,nonatomic) IBOutlet UILabel *questionTextLb;

//问题描述背景view
@property(strong,nonatomic) IBOutlet UIView *questionTextLbBgView;

//问题类型图片
@property(strong,nonatomic) IBOutlet UIImageView *optionTypeImageView;

//问题图片
@property(strong,nonatomic) IBOutlet UIImageView *animatedImageView;

//答案列表
@property(strong,nonatomic) IBOutlet UITableView *tableView;

//答案cell nib
@property(strong,nonatomic) UINib *cellNib;

//答案数组
@property(strong,nonatomic) NSArray *dataAry;

//问题item
@property(strong,nonatomic) QuestionItem *questionItem;

@property(strong,nonatomic) IBOutlet UILabel *resultLb;

@property(strong,nonatomic) IBOutlet UIButton *commitBtn;

@property(strong,nonatomic) IBOutlet UILabel *resultLb22;

@property(weak,nonatomic) QuestionListController *delegate;

@property (nonatomic ,weak) IBOutlet PlayerView *playerView;

@property (nonatomic ,strong) AVPlayer *player;

@property (strong,nonatomic) NSURL *videoURL;

-(void)vedioPlay:(NSString *)videoName;

@end
