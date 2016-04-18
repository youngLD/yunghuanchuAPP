//
//  Utils.h
//  APP
//
//  Created by SarnathAir on 14-2-8.
//  Copyright (c) 2014年 SarnathAir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "WQUserDataManager.h"
@interface Utils : NSObject

/**
 * @brief 获取当前登录状态
 *
 * @return 登录状态
 */
//+(User * )getCurrentUserInfo;

/**
 *	@brief	判断网络状态
 *
 *	@return	网络状态
 */
+(NSString *)currentNetWorkStatusString;

/**
 * @discription 把float型时间转换成 yyyy-MM-dd HH:mm 格式
 * @param
 *      string - 要转换的float时间
 * @return
 *      转换后的时间
 */
+(NSString *)getmfDateFromDotNetJSONString:(NSString *)string;

/**
 *	@brief	隐藏tableview 多余的分割线，在tableview的数据源为空时可能不生效，可以在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的separatorStyle设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

/**
 * @discription 显示加载框MBProgressHUD
 * @param
 *      view - 要显示MBProgressHUD的视图
 *      text - 加载框上的提示信息
 *      mBProgressHUDDelegate - MBProgressHUD的委托对象
 * @return
 *      none
 */
+(void)addProgressHUBInView:(UIView *)view textInfo:(NSString *)text delegate:(id<MBProgressHUDDelegate>)mBProgressHUDDelegate;

/**
 *  progress hub 动画
 *
 *  @param view                  父视图
 *  @param text                  动画名称
 *  @param mBProgressHUDDelegate
 */
+(void)addProgressHUBInView:(UIView *)view animation:(NSString *)text delegate:(id<MBProgressHUDDelegate>)mBProgressHUDDelegate;

/**
 * @discription 移除加载框MBProgressHUD
 * @param
 *      view - 要移除MBProgressHUD的视图
 * @return
 *      none
 */
+(void)removeProgressHUB:(UIView *)view;

/**
 *	@brief	让label自适应高度（height），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoHeightLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font;

/**
 *	@brief	让label自适应高度（height），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoHeightLabel2:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font;

/**
 *	@brief	让label自适应宽度（width），并赋予字符串
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(void)autoWithLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font;

/**
 *	@brief	给视图设置边线
 *
 *	@param 	view 	要设置边线的视图
 */
+(void)setBorderforView:(UIView *)view;

/**
 *	@brief	压缩图片
 *
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *	@brief	Unicode转nsstring
 *
 *	@param 	unicodeStr 	Unicode字符串
 *
 *	@return	转换后的NSString
 */
+(NSString *)replaceUnicode:(NSString *)unicodeStr;

/**
 *	@brief	弹出提示框
 */
+(void)showMessage:(NSString *)message;

/**
 *	@brief	计算label高度
 *
 *	@param 	label 	目标label
 *	@param 	string 	目标字符串
 *	@param 	maxRect 	label的原点和最大尺寸信息
 */
+(CGFloat)caculateHeightLabel:(UILabel *)label withString:(NSString *)string setFrame:(CGRect )maxRect font:(UIFont *)font;

/**
 *  解析出JSON字典中的值，防止数据问题出现崩溃
 *
 *  @param dataDic
 *  @param key
 *
 *  @return
 */
+(NSString *)getValueFrom:(NSDictionary *)dataDic byKey:(NSString *)key;
/**
 *	@brief	通过键值获取当前语言环境下的值
 *
 *	@param 	keyVar 	参数keyVar 键
 *
 *	@return	返回 国际化对应的值
 */
+(NSString *) getLocalized:(NSString *)keyVar;


/**
 *	@brief	判断是否是第一次启动（包括程序升级后第一次启动）
 *
 *	@return	yes or no
 */
+(BOOL)isFirstLoad;

/**
 *  拍照时旋转90度，保存时调整回来
 *
 *  @param aImage 原图片
 *
 *  @return 旋转后图片
 */
+(UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  把方形视图做成圆形
 *
 *  @param orginalView
 */
+(void)makeCircleView:(UIView *)orginalView;

/**
 *  更具JSON字符串得到字典
 *
 *  @param string 字符串
 *
 *  @return 字典
 */
+(NSDictionary *)objectFromJSONString:(NSString *)string;

/**
 *  获取浮点型时间
 *
 *  @return
 */
+(NSString *)getCurrentTime;

/**
 *  获取当前媒体文件的时间长度
 *
 *  @param filePath 文件路径
 *
 *  @return 秒
 */
+(CGFloat)getMediaDuration:(NSString *)filePath;

/**
 *  判断字符串是否为空
 *
 *  @param str 要判断的字符串
 *
 *  @return 结果
 */
+(BOOL)isNullOrEmpty:(NSString *)str;

/**
 *  判断数组是否未空
 *
 *  @param ary
 *
 *  @return
 */
+(BOOL)isArrayNullOrEmpty:(NSArray *)ary;


+(void)caculateLableSize:(UILabel *)lb withString:(NSString *)string maxSize:(CGSize)maxSize;
+(void)caculateLableSize2:(UILabel *)lb withString:(NSString *)string maxSize:(CGSize)maxSize;

/**
 *  根据玩法类型返回玩法名称
 *
 *  @param type 类型代码
 *
 *  @return 玩法名称
 */
//+(NSString *)getLotteryNameBytype:(LotteryType)type;

/**
 *	@brief	自适应label的atributeString
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(void)caculateLableSize:(UILabel *)lb withAtributeString:(NSString *)string maxSize:(CGSize)maxSize;

/**
 *	@brief	自适应label的atributeString
 *
 *	@param 	lb 	要自自适应的label
 *	@param 	string 	自适应的文字
 *	@param 	size 	限制的最大尺寸
 */
+(CGSize)getLableSizeFont:(UIFont *)font withAtributeString:(NSString *)string maxSize:(CGSize)maxSize;

/**
 *  针对iOS7以上系统，table view cell 分割线居左
 *
 *  @param tableView
 *  @param cell
 */
+(void)setSeparatorInsetZero:(UITableView *)tableView cell:(UITableViewCell *)cell;

//获取时间对象
+(NSDate*) stringToDate:(NSString *)date formateStr:(NSString *)formate;

//获取时间字符串
+(NSString*) dateToString:(NSDate *)date formateStr:(NSString *)formate;

/**
 *  对数组进行随进排序
 *
 *  @param originalAry 原数组
 *
 *  @return 随机排序后的数组
 */
+(NSMutableArray *) randomizedArray:(NSArray *)originalAry;

/**
 *  字符串中是否包含中文
 *
 *  @param string
 *
 *  @return
 */
+(BOOL)contentHanzi:(NSString *)string;

/**
 *  当前的时间 年月日格式
 *
 *  @return
 */
+(NSString *)getcurrentMonthday;

/**
 *  16进制颜色
 *
 *  @param color
 *
 *  @return
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  是否显示过引导图
 */
+ (void) storeGuideViewFinished;

/**
 *  是否显示过当前版本的引导图
 *
 *  @return
 */
+ (BOOL) getGuideViewFinished;

/**
 *  当前版本号
 *
 *  @return
 */
+ (NSString *) getVersion;
@end
