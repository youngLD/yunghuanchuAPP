//
//  VideoListViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/23.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralWebRequest.h"
#import "VideoWebRequest.h"
#import "VideoItem.h"
@class VideoDownCell;

@interface VideoListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) IBOutlet UINib *nib0;
@property(strong,nonatomic) IBOutlet UINib *nib1;
@property(strong,nonatomic) VideoWebRequest *videoRequest0;
@property(strong,nonatomic) VideoWebRequest *videoRequest1;

@property(strong,nonatomic) NSMutableArray *videoAry0;
@property(strong,nonatomic) NSMutableArray *videoAry1;

@property(nonatomic) BOOL isLoadVideo0;
@property(nonatomic) BOOL isLoadVideo1;

@property(strong,nonatomic) IBOutlet UITableView *talbeview0;
@property(strong,nonatomic) IBOutlet UITableView *talbeview1;

@property(strong,nonatomic) IBOutlet UIButton *titleBtn0;
@property(strong,nonatomic) IBOutlet UIButton *titleBtn1;

@property(strong,nonatomic) IBOutlet UIView *titleHeaderView;

//0:科目二  1:科目三
@property(nonatomic) int firstTag;

- (void)setProgress:(float)newProgress cell:(VideoDownCell *)cell;

+(VideoListViewController *)shareInstance;
@end
