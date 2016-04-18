//
//  AiticleViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoWebRequest.h"

@interface ArticleViewController : UIViewController

@property(strong,nonatomic) IBOutlet UIWebView *webView;

/**
 *  文章类型：0：考前准备，1：合格标准，2：考试经验，3：评判标准，4：16项秘籍，5：夜考须知，6：路考秘诀，7：考场经验，8：克服恐惧
 */
@property(nonatomic) NSInteger flag;

@property(strong,nonatomic) NSString *uid;

@property(strong,nonatomic) VideoWebRequest *request;

@property(strong,nonatomic) IBOutlet UILabel *titleLb;

@property(strong,nonatomic) IBOutlet UILabel *timeLb;

//是否是秘籍指导详情
@property(nonatomic) BOOL isMJZDDetail;
@end
