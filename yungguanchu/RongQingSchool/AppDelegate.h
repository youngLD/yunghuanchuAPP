//
//  AppDelegate.h
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeTuiSdk.h"
#import "LeftSlideViewController.h"
#import "Reachability.h"

#define kGtAppId           @"yNDlpZOo7nAwNestkUZpJ9"
#define kGtAppKey          @"BEQ3HpGteq7sIvDSdJ22g"
#define kGtAppSecret       @"4BtVTylslZ56V1WiVlJkd5"
@class TabBarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TabBarViewController *mainViewController;

@property (strong, nonatomic) Reachability *hostReach;


@end

