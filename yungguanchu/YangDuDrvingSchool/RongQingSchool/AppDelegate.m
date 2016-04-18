//
//  AppDelegate.m
//  RongQingSchool
//
//  Created by caitong on 15/8/19.
//  Copyright (c) 2015年 荣庆驾校. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "SchoolDetailController.h"
#import "FileUtil.h"
#import "TGViewController.h"
#import "BaseDao.h"
#import "GuideViewController.h"
#import "ReservationHomeController.h"
#import "Reachability.h"

@interface AppDelegate ()

@end
//是否显示开机引导页，每次升级的版本的时候记得修改
BOOL needDisplayGuideView = NO;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *path = NSHomeDirectory();//主目录
    //NSLog(@"NSHomeDirectory:%@",path);
    NSString *userName = NSUserName();//与上面相同
    NSString *rootPath = NSHomeDirectoryForUser(userName);
    //NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSLog(@"NSDocumentDirectory:%@",documentsDirectory);

    //CLog(@"%@",[FileUtil getDirectoryPath:@""]);
    [self initData];
    
    //状态栏颜色
    if(IS_IOS6)
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (needDisplayGuideView && ![Utils getGuideViewFinished]) {
        self.window.rootViewController = [[GuideViewController alloc] init];
    }else {
        self.window.rootViewController = [[TGViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    [self networkMonitor];
    return YES;
}

-(void)networkMonitor{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostname: @"www.baidu.com"];
    [self.hostReach startNotifier];
}

- (void)reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            [Utils showMessage:@"网络不可用"];
            break;
        }
            
        case ReachableViaWWAN:
        {
            [Utils showMessage:@"当前蜂窝移动网络"];
            break;
        }
        case ReachableViaWiFi:
        {
            /*
            [Utils showMessage:@"当前网络WiFi"];
             */
            break;
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initData
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *gpsPath = [documentsDirectory stringByAppendingString: @"/config.xml"];
    //    [[NSFileManager defaultManager] createFileAtPath: gpsPath contents:nil attributes:nil];
    BOOL copySucceeded = NO;
    
    NSString *fileName = @"mydatabase";
    
    // Get our document path.
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths objectAtIndex:0];
    
    // Get the full path to our file.
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    // Get a file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Does the database already exist? (If not, copy it from our bundle)
    if(![fileManager fileExistsAtPath: filePath])
    {
        CLog(@"copyFromBundle - checking for presence of \"%@\"...", fileName);
        // Get the bundle location
        NSString *bundleDBPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        
        // Copy the DB to our document directory.
        copySucceeded = [fileManager copyItemAtPath:bundleDBPath
                                             toPath:filePath
                                              error:nil];
        
        if(!copySucceeded) {
            NSLog(@"copyFromBundle - Unable to copy \"%@\" to document directory.", fileName);
        }
        else {
            NSLog(@"copyFromBundle - Succesfully copied \"%@\" to document directory.", fileName);
        }
    }
    else
    {
        
    }
    
    NSString* sql=@"CREATE TABLE IF NOT EXISTS exam_record ( \
    id integer PRIMARY KEY AUTOINCREMENT,\
    userID text  ,\
    subject_type integer ,\
    score text  ,\
    time text ,\
    date text);";
    
    
    BaseDao *dao = [[BaseDao alloc] init];
    [dao openDataBase];
    [dao executeUpdate:sql];
    [dao closeDataBase];
}

@end
