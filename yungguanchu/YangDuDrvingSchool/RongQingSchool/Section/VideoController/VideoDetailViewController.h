//
//  VideoDetailViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/24.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALMoviePlayerController.h"
#import "VideoWebRequest.h"
#import "VideoItem.h"

@interface VideoDetailViewController : UIViewController<ALMoviePlayerControllerDelegate>



@property(strong,nonatomic) VideoWebRequest *videoRequest;

@property(strong,nonatomic) VideoItem *videoItem;

@property(strong,nonatomic) VideoItem *detailVideoItem;

@property(strong,nonatomic) IBOutlet UIWebView *webView;

@property(strong,nonatomic) IBOutlet UIButton *backBtn;
@end
