//
//  FlowInfoViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebRequest.h"

@interface FlowInfoViewController : UIViewController

@property(strong,nonatomic) WebRequest *request;

@property(strong,nonatomic) IBOutlet UIScrollView *normalScrollView;

@property(strong,nonatomic) IBOutlet UIScrollView *timerScrollView;
/************************ 计时班 ****************/
/**
 *  学员缴费
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanjiaofeijishiView;

/**
 *  学员建档
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanjiandangjishiView;

/**
 *  学员照相
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanzhaoxiangjishiView;

@property(strong,nonatomic) IBOutlet UIView *kemu1jishiView;
@property(strong,nonatomic) IBOutlet UIView *kemu2jishiView;
@property(strong,nonatomic) IBOutlet UIView *kemu3jishiView;
@property(strong,nonatomic) IBOutlet UIView *jieyejishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu1monijishiLb;
@property (strong, nonatomic) IBOutlet UIView *peixunjiluhaolurujishiView;
@property (strong, nonatomic) IBOutlet UIView *zhunkaozhenghaolurujishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu1monichengjihegejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu1gaizhangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu1kaoshiyuyuejishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu1kaoshiyuyueshenhejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu1tidangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu1kaoshijishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu1fuwupingjiajishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu1chengjihegejishiView;
@property (strong, nonatomic) IBOutlet UIView *peixunyuyuepingjiajishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2peixunyuyuejishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2peixunyuyuepingjiajishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu2gaizhangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2kaoshiyuyuejishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2kaoshiyuyueshenhejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu2tidangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2kaoshijishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2yuyuepingjiajishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu2chengjihegejishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3peixunyuyuejishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3peixunyuyuepingjiajishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu3gaizhangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3kaoshiyuyuejishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3kaoshiyuyueshenhejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu3tidangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3kaoshijishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3kaoshihegejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu3lilunkaoshishenhejishiView;
@property (strong, nonatomic) IBOutlet UIView *kemu3liluntidangjishiView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3lilunkaoshijishiLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3lilunchengjihegejishiView;

/************************ 普通班 ****************/
/**
 *  学员缴费
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanjiaofeiputongView;

/**
 *  学员建档
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanjiandangputongView;

/**
 *  学员照相
 */
@property(strong,nonatomic) IBOutlet UIView *xueyuanzhaoxiangputongView;

@property(strong,nonatomic) IBOutlet UIView *kemu1putongView;
@property(strong,nonatomic) IBOutlet UIView *kemu2putongView;
@property(strong,nonatomic) IBOutlet UIView *kemu3putongView;
@property(strong,nonatomic) IBOutlet UIView *jieyeputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu1moniputongLb;
@property (strong, nonatomic) IBOutlet UIView *peixunjiluhaoluruputongView;
@property (strong, nonatomic) IBOutlet UIView *zhunkaozhenghaoluruputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu1monichengjihegeputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu1gaizhangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kmu1kaoshiyuyueputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu1kaoshiyuyueshenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu1tidangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu1kaoshiputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu1fuwupingjiaputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu1chengjihegeputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2fencheyuyueputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2fencheyuyueshenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu2gaizhangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2kaoshiyuyueputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2kaoshiyuyueshenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu2tidangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu2kaoshiputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu2fuwupingjiaputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu2chengjihegeputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3fencheyuyueputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3fencheyuyueshenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3gaizhangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3kaoshiyuyueputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3kaoshiyuyueshenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3tidangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3kaoshiputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3kaoshihegeputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3fuwupingjiaputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3lilunkaoshishenheputongView;
@property (strong, nonatomic) IBOutlet UIView *kemu3liluntidangputongView;
@property (strong, nonatomic) IBOutlet UILabel *kemu3lilunkaoshiputongLb;
@property (strong, nonatomic) IBOutlet UIView *kemu3lilunchengjihegeputongView;



















@end
