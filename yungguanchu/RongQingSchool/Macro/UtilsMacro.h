//
//  UtilsMacro.h
//  House
//  方便使用的宏定义
//  Created by iOSdev on 14-3-25.
//  Copyright (c) 2014年 Bandao. All rights reserved.
//

#define UIColorFromRGB(r,g,b) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:1]

#define NSStringFromInt(intValue) ([NSString stringWithFormat:@"%ld",(long)intValue])

//判断是否是Iphone4的宏
#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是Iphone5的宏
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是Iphone5的宏
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是Iphone5的宏
#define IS_IPHONE_6_PLUS  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//IOS7
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)

//IOS7
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

//IOS8
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#ifdef DEBUG
#define CLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define CLog(fmt, ...)
#endif

//[NSString stringWithFormat:@""] 宏定义
#define NSStringFromFormat(fmt, ...) [NSString stringWithFormat:(fmt),##__VA_ARGS__]

//屏幕尺寸
#define UISCREEN_SIZE ([[UIScreen mainScreen] bounds].size)

//导航栏+状态栏高度
#define  KTOP_HEIGHT ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)? 52:64)

//不同宽度的和320宽度的缩放比
#define WIDTH_SCALE (UISCREEN_SIZE.width/320)

#define ServerIP_Add_Suffix(suffix) [NSString stringWithFormat:@"%@%@",SERVER_IP,suffix]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


/*
 如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成
 另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成
 改变权限（设置程序-> 通用 -> 隐私 -> 广告 -> 限制广告追踪）广告标示符也会重新生成
 
 "Reset All Settings" in iOS Settings app
 No effect
 
 "Erase All Content and Settings" in iOS Settings app
 Resets both advertisingIdentifier and identifierForVendor.
 
 Restoring a device via iTunes
 Resets both advertisingIdentifier and identifierForVendor.
 
 Deleting an app from the device
 Resets identifierForVendor, if this was the last app with a specific Team ID.
 
 Updating an app
 No effect
 
 Enabling/disabling "Limit Ad Tracking"
 iOS 6.0.1: No effect
 iOS 6.1.3: Resets the advertisingIdentifier.
 
 System Update OTA (iOS 6.0.1 to iOS 6.1.3)
 No effect
 
 System Update OTA (iOS 6.1.3 to iOS 7.0.0)
 Resets the identifierForVendor in some cases. (1)
 
 System Update via iTunes (iOS 6.1.3 to iOS 7.0.0)
 Resets the identifierForVendor in some cases. (1)
 
 "Reset Advertising Identifier" in iOS Settings app
 Resets the advertisingIdentifier. If some running (or suspended) apps already requested a advertisingIdentifier, they will not be able to retrieve the new one until they are stopped and relaunched.
 
 Backup via iTunes
 No effect
 
 Restore of a Backup via iTunes (to the same device)
 Restores the backed-up settings, including both advertisingIdentifier and identifierForVendor. Note: If you delete multiple apps with some Team ID before the restore, the identifierForVendor will never be reset again until you reinstall all apps with that Team ID you had installed and delete them again. This seems to be a bug.
 
 Restore of a Backup via iTunes (to a different device)
 Resets both advertisingIdentifier and identifierForVendor.
 */
#define ADID [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]