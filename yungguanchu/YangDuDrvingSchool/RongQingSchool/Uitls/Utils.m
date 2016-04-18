//
//  Utils.m
//  APP
//
//  Created by SarnathAir on 14-2-8.
//  Copyright (c) 2014年 SarnathAir. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
#import "FileUtil.h"
#import "JSONKit.h"
#import "FLAnimatedImage.h"
@implementation Utils

/**
 *	@brief	判断网络状态
 *
 *	@return	网络状态
 */
+(NSString *)currentNetWorkStatusString
{
    NSString *netWorkStatus ;
    
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    
    NSNumber *dataNetworkItemView = nil;
    
    
    for (id subview in subviews) {
        
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            
            dataNetworkItemView = subview;
            
            break;
            
        }
        
    }
    
    
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    
    if (num == nil) {
        
//        CLog(@"当前无网络1");
        netWorkStatus = nil;
        
        
    }else{
        
        int n = [num intValue];
        
        if (n == 0) {
            
            netWorkStatus = nil;
//            CLog(@"当前无网络2");
            
        }else if (n == 1){
            
            netWorkStatus = @"2G";
//            CLog(@"当前网络2G");
            
        }else if (n == 2){
//            CLog(@"当前网络3G");
            netWorkStatus = @"3G";
            
        }else{
//            CLog(@"当前网络Wifi");
            netWorkStatus = @"Wifi";
            
        }
        
    }
    return netWorkStatus;
    
}

/**
 * @discription 把float型时间转换成 yyyy-MM-dd HH:mm 格式
 * @param
 *      string - 要转换的float时间
 * @return
 *      转换后的时间
 */
+(NSString *)getmfDateFromDotNetJSONString:(NSString *)string
{
    NSString* dateAsString = string;
    dateAsString = [dateAsString stringByReplacingOccurrencesOfString:@"/Date("
                                                           withString:@""];
    dateAsString = [dateAsString stringByReplacingOccurrencesOfString:@"+0800)/"
                                                           withString:@""];
    
    unsigned long long milliseconds = [dateAsString longLongValue];
    NSTimeInterval interval = milliseconds/1000;
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDate *date = [Utils dateWithTimeIntervalSince0001:interval];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* createTime = [formatter stringFromDate:date];
    
    NSString *currentTime = [Utils getcurrentMonthday];
    if([createTime isEqualToString:currentTime])
    {
        [formatter setDateFormat:@"HH:mm"];
        createTime = [formatter stringFromDate:date];
    }
    else
    {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        createTime = [formatter stringFromDate:date];
    }
    
    return createTime;
}

/*
 *  根据从元年过后的秒数生成时间
 */
+(NSDate *)dateWithTimeIntervalSince0001:(NSTimeInterval)time{
    return [NSDate dateWithTimeIntervalSince1970:time - 62135596800l];
}

/**
 *	@brief	隐藏tableview 多余的分割线，在tableview的数据源为空时可能不生效，可以在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的separatorStyle设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 * @discription 显示加载框MBProgressHUD
 * @param
 *      view - 要显示MBProgressHUD的视图
 *      text - 加载框上的提示信息
 *      mBProgressHUDDelegate - MBProgressHUD的委托对象
 * @return
 *      none
 */
+(void)addProgressHUBInView:(UIView *)view textInfo:(NSString *)text delegate:(id<MBProgressHUDDelegate>)mBProgressHUDDelegate
{
//    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD* progress = [[MBProgressHUD alloc] initWithView:view];
    //    [progress setMode:MBProgressHUDModeDeterminate];
    progress.minSize = CGSizeMake(135.0, 135.0);
    [view addSubview:progress];
    [view bringSubviewToFront:progress];
    progress.delegate = mBProgressHUDDelegate;
    progress.labelText = [[Utils getLocalized:text] length] ? [Utils getLocalized:text]:text;
    progress.color = [UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:0.80];
    [progress show:YES];
}

/**
 *  progress hub 动画
 *
 *  @param view                  父视图
 *  @param text                  动画名称
 *  @param mBProgressHUDDelegate
 */
+(void)addProgressHUBInView:(UIView *)view animation:(NSString *)text delegate:(id<MBProgressHUDDelegate>)mBProgressHUDDelegate
{
    MBProgressHUD* progress = [[MBProgressHUD alloc] initWithView:view];
    progress.mode = MBProgressHUDModeCustomView;
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:text withExtension:@""];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    FLAnimatedImageView *animationV = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, animatedImage1.size.width, animatedImage1.size.height)];
    animationV.animatedImage = animatedImage1;
    progress.customView = animationV;
    
    progress.minSize = CGSizeMake(135.0, 135.0);
    [view addSubview:progress];
    [view bringSubviewToFront:progress];
    progress.delegate = mBProgressHUDDelegate;
    progress.color = [UIColor clearColor];
    [progress show:YES];
}
/**
 * @discription 移除加载框MBProgressHUD
 * @param
 *      view - 要移除MBProgressHUD的视图
 * @return
 *      none
 */
+(void)removeProgressHUB:(UIView *)view
{
//    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

/**
 *	@brief	通过键值获取当前语言环境下的值
 *
 *	@param 	keyVar 	参数keyVar 键
 *
 *	@return	返回 国际化对应的值
 */
+(NSString *) getLocalized:(NSString *)keyVar
{
    return NSLocalizedString(keyVar, nil);
}

/**
 *	@brief	让label自适应高度（height），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoHeightLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font
{
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maxSize = maxRect.size;
    [label sizeToFit];
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:label.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    //    CLog(@"label高度:%.2f",labelSize.height);
    CGFloat aWidth = maxRect.size.width>labelSize.width ? maxRect.size.width : labelSize.width;
    CGFloat aHeight = label.frame.size.height>labelSize.height?label.frame.size.height:labelSize.height;
    [label setFrame:CGRectMake(maxRect.origin.x,maxRect.origin.y, aWidth, aHeight)];
    label.text = string;
}

/**
 *	@brief	让label自适应高度（height），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoHeightLabel2:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font
{
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maxSize = maxRect.size;
    [label sizeToFit];
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:label.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    //    CLog(@"label高度:%.2f",labelSize.height);
    CGFloat aWidth = maxRect.size.width;
    CGFloat aHeight = labelSize.height;
    [label setFrame:CGRectMake(maxRect.origin.x,maxRect.origin.y, aWidth, aHeight)];
    label.text = string;
}

/**
 *	@brief	计算label高度
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(CGFloat)caculateHeightLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font
{
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maxSize = maxRect.size;
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:label.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.height;
}

/**
 *	@brief	让label自适应宽度（width），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoWithLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font
{
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize maxSize = maxRect.size;
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:label.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByCharWrapping];
    //    CLog(@"label高度:%.2f",labelSize.height);
    [label setFrame:CGRectMake(maxRect.origin.x,maxRect.origin.y, labelSize.width, labelSize.height)];
    label.text = string;
}

/**
 *	@brief	给视图设置边线
 *
 *	@param 	view 	要设置边线的视图
 */
+(void)setBorderforView:(UIView *)view
{
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

/**
 *	@brief	压缩图片
 *
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

/**
 *	@brief	Unicode转nsstring
 *
 *	@param 	unicodeStr 	Unicode字符串
 *
 *	@return	转换后的NSString
 */
+(NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    CLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

/**
 *	@brief	弹出提示框
 */
+(void)showMessage:(NSString *)message
{
//    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *keywindow = appDelegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keywindow animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.userInteractionEnabled = NO;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
    hud.color = [UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:0.90];
	hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
	
	[hud hide:YES afterDelay:3];
    if ([[Utils getLocalized:message] length]==0) {
        hud.detailsLabelText = message;
    }else{
        hud.detailsLabelText = [Utils getLocalized:message];
    }
    [hud hide:YES afterDelay:3];
}

/**
 *  解析出JSON字典中的值，防止数据问题出现崩溃
 *
 *  @param dataDic
 *  @param key
 *
 *  @return
 */
+(NSString *)getValueFrom:(NSDictionary *)dataDic byKey:(NSString *)key
{
    id vl = [dataDic objectForKey:key];
    
    NSString *value = @"";
    
    //排错处理
    if(!vl || (NSNull *)vl == [NSNull null] || vl == NULL)
        value = @"";
    else
        value = [NSString stringWithFormat:@"%@",[dataDic objectForKey:key]];
    
    
    return value;
}

/**
 *	@brief	判断是否是第一次启动（包括程序升级后第一次启动）
 *
 *	@return	yes or no
 */
+(BOOL)isFirstLoad
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion)
    {
        //        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        //        [defaults synchronize];
        return YES;
        // App is being run for first time
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        [defaults synchronize];
        return YES;
        // App has been updated since last run
    }
    return NO;
}


/**
 *  拍照时旋转90度，保存时调整回来
 *
 *  @param aImage 原图片
 *
 *  @return 旋转后图片
 */
+(UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 *  把方形视图做成圆形
 *
 *  @param orginalView
 */
+(void)makeCircleView:(UIView *)orginalView
{
    orginalView.layer.cornerRadius = orginalView.frame.size.width/2;
    orginalView.layer.masksToBounds = YES;
}

/**
 *  更具JSON字符串得到字典
 *
 *  @param string 字符串
 *
 *  @return 字典
 */
+(NSDictionary *)objectFromJSONString:(NSString *)string
{
    NSDictionary *dic = [string objectFromJSONString];
    return dic;
}

/**
 *  获取浮点型时间
 *
 *  @return
 */
+(NSString *)getCurrentTime
{    
    NSTimeInterval date = ([[NSDate date] timeIntervalSince1970] + 62135596800l)*1000;
    
    NSString *string = [NSString stringWithFormat:@"%.0f",date];
    return string;
}

/**
 *  获取当前媒体文件的时间长度
 *
 *  @param filePath 文件路径
 *
 *  @return 秒
 */
+(CGFloat)getMediaDuration:(NSString *)filePath
{
//    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
//    CMTime audioDuration = audioAsset.duration;
//    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
//    
//    return audioDurationSeconds;
    
    return 0;
}

/**
 *  当前的时间 年月日格式
 *
 *  @return
 */
+(NSString *)getcurrentMonthday
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd";
    
    NSString *currentTime = [dateFormatter stringFromDate:date];
    
    return currentTime;
}

/**
 *  判断字符串是否为空
 *
 *  @param str 要判断的字符串
 *
 *  @return 结果
 */
+(BOOL)isNullOrEmpty:(NSString *)str{
    
    //如果不是字符串，一般来讲就是数据错误
    if(![str isKindOfClass:[NSString class]]) return YES;
    
    return str == NULL || str == Nil || [str isEqual:[NSNull null]] || [str isEqualToString:@""];
}

/**
 *  判断数组是否未空
 *
 *  @param ary
 *
 *  @return
 */
+(BOOL)isArrayNullOrEmpty:(NSArray *)ary{
    
    //如果不是字符串，一般来讲就是数据错误
    if(![ary isKindOfClass:[NSArray class]]) return YES;
    
    return ary == NULL || ary == Nil || [ary isEqual:[NSNull null]] || ary.count == 0;
}

/**
 *	@brief	自适应table header 上的label
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(void)caculateLableSize:(UILabel *)lb withString:(NSString *)string maxSize:(CGSize)maxSize
{
    lb.numberOfLines = 0;
    lb.lineBreakMode = NSLineBreakByWordWrapping;
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:lb.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    
    //如果两行
    if(labelSize.height > 16)
    {
        lb.frame = CGRectMake(lb.frame.origin.x, 6, lb.frame.size.width, labelSize.height);
    }
    else
    {
        lb.frame = CGRectMake(lb.frame.origin.x, 10, lb.frame.size.width, labelSize.height);
    }
    
    
    lb.text = string;
}

/**
 *	@brief	自适应label的atributeString
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(void)caculateLableSize:(UILabel *)lb withAtributeString:(NSString *)string maxSize:(CGSize)maxSize
{
    lb.numberOfLines = 0;
    lb.lineBreakMode = NSLineBreakByWordWrapping;
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:lb.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    
    lb.frame = CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, labelSize.height);
}

/**
 *	@brief	自适应label的atributeString
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(CGSize)getLableSizeFont:(UIFont *)font withAtributeString:(NSString *)string maxSize:(CGSize)maxSize{
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize;
}

/**
 *	@brief	自适应table header 上的label
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(void)caculateLableSize2:(UILabel *)lb withString:(NSString *)string maxSize:(CGSize)maxSize
{
    lb.numberOfLines = 0;
    lb.lineBreakMode = NSLineBreakByWordWrapping;
    
    //根据str计算label实际大小
    CGSize labelSize = [string sizeWithFont:lb.font
                          constrainedToSize:maxSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    
    //如果两行
    if(labelSize.height > 16)
    {
        lb.frame = CGRectMake(lb.frame.origin.x, 4, lb.frame.size.width, labelSize.height);
    }
    else
    {
        lb.frame = CGRectMake(lb.frame.origin.x, 8, lb.frame.size.width, labelSize.height);
    }
    
    
    lb.text = string;
}

//-(LotteryType)getLotteryTypeByType:(NSInteger)type{
//    
//}

/**
 *  针对iOS7以上系统，table view cell 分割线居左
 *
 *  @param tableView
 *  @param cell
 */
+(void)setSeparatorInsetZero:(UITableView *)tableView cell:(UITableViewCell *)cell{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//获取时间对象
+(NSDate*) stringToDate:(NSString *)date formateStr:(NSString *)formate
{
    NSDate *dt=nil;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    @try
    {
        dt=[formatter dateFromString:date];
    }@catch (NSException *e) {
        NSLog(@"exception is %@",[e description]);
    }
    return dt;
}

//获取时间字符串
+(NSString*) dateToString:(NSDate *)date formateStr:(NSString *)formate
{
    NSString *dateStr=nil;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    @try
    {
        dateStr=[formatter stringFromDate:date];
    }@catch (NSException *e) {
        NSLog(@"exception is %@",[e description]);
    }
    return dateStr;
}

/**
 *  对数组进行随进排序
 *
 *  @param originalAry 原数组
 *
 *  @return 随机排序后的数组
 */
+(NSMutableArray *) randomizedArray:(NSArray *)originalAry{
    NSMutableArray *results = [NSMutableArray arrayWithArray:originalAry];
    
    NSInteger i = [results count];
    while(--i > 0) {
        int j = rand() % (i+1);
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return results;
}

+(BOOL)contentHanzi:(NSString *)string{
    for(NSInteger i=0; i<string.length; i++)
    {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange(i, 1);
        NSString *word  = [string substringWithRange:range];
        BOOL b = [word getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        unichar c = [string characterAtIndex:i];
        if (b && (c >= 0x4e00 && c <= 0x9fa5)) {
            //在这个区间的是中文
            return YES;
        }
        else{
        }
        
    }
    
    return NO;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 *  是否显示过引导图
 */
+ (void) storeGuideViewFinished
{
    [[NSUserDefaults standardUserDefaults] setObject:[Utils getVersion] forKey:@"isGuideViewFinished"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  是否显示过当前版本的引导图
 *
 *  @return
 */
+ (BOOL) getGuideViewFinished
{
    NSString *s = [[NSUserDefaults standardUserDefaults] objectForKey:@"isGuideViewFinished"];
    if(![Utils isNullOrEmpty:s] && [s isEqualToString:[Utils getVersion]]){
        return YES;
    }
    return NO;
}

/**
 *  当前版本号
 *
 *  @return
 */
+ (NSString *) getVersion
{
    return [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"];
}

@end
