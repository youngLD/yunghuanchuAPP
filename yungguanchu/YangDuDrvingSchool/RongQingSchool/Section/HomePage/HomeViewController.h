//
//  HomeViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ADScrollView.h"
#import "VideoWebRequest.h"
@interface HomeViewController :BaseViewController<ADScrollViewDataSource,ADScrollViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>

@property(strong,nonatomic) ADScrollView *adScrollView;

@property(strong,nonatomic) IBOutlet UIScrollView *bgScrollView;

@property(strong,nonatomic) IBOutlet UIView *bgView2;

@property(strong,nonatomic) IBOutlet UIView *bgView3;

@property(strong,nonatomic) IBOutlet UIView *contentView1;

@property(strong,nonatomic) IBOutlet UIView *contentBarView;

@property(strong,nonatomic) IBOutlet UIButton *kemu1Btn;
@property(strong,nonatomic) IBOutlet UIImageView *kemu1leftImageView;
@property(strong,nonatomic) IBOutlet UILabel *kemu1Lb;

@property(strong,nonatomic) IBOutlet UIButton *kemu2Btn;
@property(strong,nonatomic) IBOutlet UIImageView *kemu2leftImageView;
@property(strong,nonatomic) IBOutlet UILabel *kemu2Lb;

@property(strong,nonatomic) IBOutlet UIButton *kemu3Btn;
@property(strong,nonatomic) IBOutlet UIImageView *kemu3leftImageView;
@property(strong,nonatomic) IBOutlet UILabel *kemu3Lb;

@property(strong,nonatomic) IBOutlet UIButton *kemu4Btn;
@property(strong,nonatomic) IBOutlet UIImageView *kemu4leftImageView;
@property(strong,nonatomic) IBOutlet UILabel *kemu4Lb;

@property(strong,nonatomic) IBOutlet UIScrollView *adScroll;

@property(strong,nonatomic) IBOutlet UIImageView *adPic1;

@property(strong,nonatomic) IBOutlet UIImageView *adPic2;

@property(strong,nonatomic) IBOutlet UIPageControl *pageControl;

@property(strong,nonatomic) UINib *nib0;
@property(strong,nonatomic) UINib *nib1;
@property(strong,nonatomic) UICollectionView *collectionView0;
@property(strong,nonatomic) UICollectionView *collectionView1;

@property(strong,nonatomic) IBOutlet UIView *collectionHeader0;
@property(strong,nonatomic) IBOutlet UIView *collectionHeader1;

@property(strong,nonatomic) IBOutlet UIView *v0;
@property(strong,nonatomic) IBOutlet UIView *v1;
@property(strong,nonatomic) IBOutlet UIView *v2;
@property(strong,nonatomic) IBOutlet UIView *v3;

@property(strong,nonatomic) VideoWebRequest *videoRequest0;
@property(strong,nonatomic) VideoWebRequest *videoRequest1;

@property(strong,nonatomic) NSMutableArray *videoAry0;
@property(strong,nonatomic) NSMutableArray *videoAry1;

@property(nonatomic) BOOL isLoadVideo0;
@property(nonatomic) BOOL isLoadVideo1;

@property(strong,nonatomic) IBOutlet UIWebView *webView;

@property(strong,nonatomic) IBOutlet UIImageView *launchImageView;

@end
