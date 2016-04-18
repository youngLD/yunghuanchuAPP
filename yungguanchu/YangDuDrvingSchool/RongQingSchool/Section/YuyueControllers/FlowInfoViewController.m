//
//  FlowInfoViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/25.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "FlowInfoViewController.h"

@interface FlowInfoViewController ()

@end
#define Finish_Color UIColorFromRGB(3, 180, 248)
@implementation FlowInfoViewController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"流程中心";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.normalScrollView.backgroundColor = [UIColor whiteColor];
    self.timerScrollView.backgroundColor = [UIColor whiteColor];
    
    self.normalScrollView.hidden = YES;
    self.timerScrollView.hidden = YES;
    
    
    [self requestData];
}

-(void)requestData{
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"uid", nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_FlowInfo WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        if([@"计时班" isEqualToString:[UserInfo shareUserInfo].xxlx]){
            self.timerScrollView.hidden = NO;
            self.timerScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, 1422);
            NSDictionary *jishiDic = [[resultDic objectForKey:@"Result"] objectForKey:@"Jishi"];
            
            //培训预约评价
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2pxpj"]]){
                UIImageView *im = (UIImageView *)[self.peixunyuyuepingjiajishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.peixunyuyuepingjiajishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科2培训预约
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2pxyy"]]){
                self.kemu2peixunyuyuejishiLb.textColor = Finish_Color;
            }
            //培训预约评价
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2pxpj"]]){
                UIImageView *im = (UIImageView *)[self.kemu2peixunyuyuepingjiajishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2peixunyuyuepingjiajishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2盖章
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2gz"]]){
                UIImageView *im = (UIImageView *)[self.kemu2gaizhangjishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2gaizhangjishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科2考试预约
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2ksyy"]]){
                self.kemu2kaoshiyuyuejishiLb.textColor = Finish_Color;
            }
            //科2考试预约审核
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2ksyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu2kaoshiyuyueshenhejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2kaoshiyuyueshenhejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2提档
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2td"]]){
                UIImageView *im = (UIImageView *)[self.kemu2tidangjishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2tidangjishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2考试
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2hg"]]){
                self.kemu2kaoshijishiLb.textColor = Finish_Color;
            }
            //科目2预约评价
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2pxpj"]]){
                UIImageView *im = (UIImageView *)[self.kemu2yuyuepingjiajishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2yuyuepingjiajishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2成绩合格
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k2hg"]]){
                UIImageView *im = (UIImageView *)[self.kemu2chengjihegejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2chengjihegejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3培训预约
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3pxyy"]]){
                self.kemu3peixunyuyuejishiLb.textColor = Finish_Color;
            }
            //培训预约评价
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3pxpj"]]){
                UIImageView *im = (UIImageView *)[self.kemu3peixunyuyuepingjiajishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3peixunyuyuepingjiajishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3盖章
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3gz"]]){
                UIImageView *im = (UIImageView *)[self.kemu3gaizhangjishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3gaizhangjishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3考试预约
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3ksyy"]]){
                self.kemu3kaoshiyuyuejishiLb.textColor = Finish_Color;
            }
            //科目3考试预约审核
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3ksyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu3kaoshiyuyueshenhejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3kaoshiyuyueshenhejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3提档
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3td"]]){
                UIImageView *im = (UIImageView *)[self.kemu3tidangjishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3tidangjishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3考试
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3kshg"]]){
                self.kemu3kaoshijishiLb.textColor = Finish_Color;
            }
            //科目3考试合格
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3kshg"]]){
                UIImageView *im = (UIImageView *)[self.kemu3kaoshihegejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3kaoshihegejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3理论考试审核
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3llkssh"]]){
                UIImageView *im = (UIImageView *)[self.kemu3lilunkaoshishenhejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3lilunkaoshishenhejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3理论提档
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3lltd"]]){
                UIImageView *im = (UIImageView *)[self.kemu3liluntidangjishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3liluntidangjishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3理论考试
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3llhg"]]){
                self.kemu3lilunkaoshijishiLb.textColor = Finish_Color;
            }
            //科目3理论考试成绩合格
            if([@1 isEqualToNumber:[jishiDic objectForKey:@"k3llhg"]]){
                UIImageView *im = (UIImageView *)[self.kemu3lilunchengjihegejishiView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3lilunchengjihegejishiView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            
            
            
        }
        else{
            self.normalScrollView.hidden = NO;
            self.normalScrollView.contentSize = CGSizeMake(UISCREEN_SIZE.width, 1422);
            
            NSDictionary *putongDic = [[resultDic objectForKey:@"Result"] objectForKey:@"Putong"];
            
            //科2分车预约
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2fcyy"]]){
                self.kemu2fencheyuyueputongLb.textColor = Finish_Color;
            }
            //科2分车预约审核
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2fcyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu2fencheyuyueshenheputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2fencheyuyueshenheputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2盖章
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2gz"]]){
                UIImageView *im = (UIImageView *)[self.kemu2gaizhangputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2gaizhangputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科2考试预约
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2ksyy"]]){
                self.kemu2kaoshiyuyueputongLb.textColor = Finish_Color;
            }
            //科2考试预约审核
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2ksyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu2kaoshiyuyueshenheputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2kaoshiyuyueshenheputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2提档
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2td"]]){
                UIImageView *im = (UIImageView *)[self.kemu2tidangputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2tidangputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2考试
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2hg"]]){
                self.kemu2kaoshiputongLb.textColor = Finish_Color;
            }
            //科目2服务评价
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2fwu"]]){
                UIImageView *im = (UIImageView *)[self.kemu2fuwupingjiaputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2fuwupingjiaputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目2成绩合格
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k2hg"]]){
                UIImageView *im = (UIImageView *)[self.kemu2chengjihegeputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu2chengjihegeputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3分车预约
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3fcyy"]]){
                self.kemu3fencheyuyueputongView.textColor = Finish_Color;
            }
            //科目3分车预约审核
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3fcyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu3fencheyuyueshenheputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3fencheyuyueshenheputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3盖章
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3gz"]]){
                UIImageView *im = (UIImageView *)[self.kemu3gaizhangputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3gaizhangputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3考试预约
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3ksyy"]]){
                self.kemu3kaoshiyuyueputongLb.textColor = Finish_Color;
            }
            //科3考试预约审核
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3ksyysh"]]){
                UIImageView *im = (UIImageView *)[self.kemu3kaoshiyuyueshenheputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3kaoshiyuyueshenheputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科3提档
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3td"]]){
                UIImageView *im = (UIImageView *)[self.kemu3tidangputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3tidangputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3考试
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3kshg"]]){
                self.kemu3kaoshiputongLb.textColor = Finish_Color;
            }
            //科目3考试合格
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3kshg"]]){
                UIImageView *im = (UIImageView *)[self.kemu3kaoshihegeputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3kaoshihegeputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科3服务评价
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3fwu"]]){
                UIImageView *im = (UIImageView *)[self.kemu3fuwupingjiaputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3fuwupingjiaputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科目3理论考试审核
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3llkssh"]]){
                UIImageView *im = (UIImageView *)[self.kemu3lilunkaoshishenheputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3lilunkaoshishenheputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科3理论提档
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3lltd"]]){
                UIImageView *im = (UIImageView *)[self.kemu3liluntidangputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3liluntidangputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            //科3理论考试
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3llhg"]]){
                self.kemu3lilunkaoshiputongLb.textColor = Finish_Color;
            }
            //科3理论考试合格
            if([@1 isEqualToNumber:[putongDic objectForKey:@"k3llhg"]]){
                UIImageView *im = (UIImageView *)[self.kemu3lilunchengjihegeputongView viewWithTag:1];
                im.image = [UIImage imageNamed:@"list_correct"];
                UILabel *lb = (UILabel *)[self.kemu3lilunchengjihegeputongView viewWithTag:2];
                lb.textColor = Finish_Color;
            }
            
            
        }
        
        NSDictionary *tongyongDic = [[resultDic objectForKey:@"Result"] objectForKey:@"Tongyong"];
        
        /*********************** 通用 ********************/
        //学员缴费
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"jf"]]){
            UIImageView *im = (UIImageView *)[self.xueyuanjiaofeijishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.xueyuanjiaofeijishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.xueyuanjiaofeiputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.xueyuanjiaofeiputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //学员建档
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"jd"]]){
            UIImageView *im = (UIImageView *)[self.xueyuanjiandangjishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.xueyuanjiandangjishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.xueyuanjiandangputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.xueyuanjiandangputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //学员照相
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"zx"]]){
            UIImageView *im = (UIImageView *)[self.xueyuanzhaoxiangjishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.xueyuanzhaoxiangjishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.xueyuanzhaoxiangputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.xueyuanzhaoxiangputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1"]]){
            UIImageView *im = (UIImageView *)[self.kemu1jishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"kemu1_blue"];
            UILabel *lb = (UILabel *)[self.kemu1jishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1putongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"kemu1_blue"];
            UILabel *lb2 = (UILabel *)[self.kemu1putongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科1模拟
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1mnks"]]){
            self.kemu1monijishiLb.textColor = Finish_Color;
            self.kemu1moniputongLb.textColor = Finish_Color;
        }
        //培训记录号录入
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"pxjlh"]]){
            UIImageView *im = (UIImageView *)[self.peixunjiluhaolurujishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.peixunjiluhaolurujishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.peixunjiluhaoluruputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.peixunjiluhaoluruputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //准考证号
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"zkzh"]]){
            UIImageView *im = (UIImageView *)[self.zhunkaozhenghaolurujishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.zhunkaozhenghaolurujishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.zhunkaozhenghaoluruputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.zhunkaozhenghaoluruputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科1模拟成绩合格
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1mnhg"]]){
            UIImageView *im = (UIImageView *)[self.kemu1monichengjihegejishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1monichengjihegejishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1monichengjihegeputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1monichengjihegeputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1盖章
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1gz"]]){
            UIImageView *im = (UIImageView *)[self.kemu1gaizhangjishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1gaizhangjishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1gaizhangputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1gaizhangputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1考试预约
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1ksyy"]]){
            self.kemu1kaoshiyuyuejishiLb.textColor = Finish_Color;
            self.kmu1kaoshiyuyueputongView.textColor = Finish_Color;
        }
        //科目1考试预约审核
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1ksyysh"]]){
            UIImageView *im = (UIImageView *)[self.kemu1kaoshiyuyueshenhejishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1kaoshiyuyueshenhejishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1kaoshiyuyueshenheputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1kaoshiyuyueshenheputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1提档
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1td"]]){
            UIImageView *im = (UIImageView *)[self.kemu1tidangjishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1tidangjishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1tidangputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1tidangputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1考试
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1hg"]]){
            self.kemu1kaoshijishiView.textColor = Finish_Color;
            self.kemu1kaoshiputongLb.textColor = Finish_Color;
        }
        //科目1服务评价
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1fwu"]]){
            UIImageView *im = (UIImageView *)[self.kemu1fuwupingjiajishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1fuwupingjiajishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1fuwupingjiaputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1fuwupingjiaputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目1成绩合格
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k1hg"]]){
            UIImageView *im = (UIImageView *)[self.kemu1chengjihegejishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb = (UILabel *)[self.kemu1chengjihegejishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu1chengjihegeputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"list_correct"];
            UILabel *lb2 = (UILabel *)[self.kemu1chengjihegeputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目2
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k2"]]){
            UIImageView *im = (UIImageView *)[self.kemu2jishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"kemu2_blue"];
            UILabel *lb = (UILabel *)[self.kemu2jishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu2putongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"kemu2_blue"];
            UILabel *lb2 = (UILabel *)[self.kemu2putongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //科目3
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"k3"]]){
            UIImageView *im = (UIImageView *)[self.kemu3jishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"kemu3_blue"];
            UILabel *lb = (UILabel *)[self.kemu3jishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.kemu3putongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"kemu3_blue"];
            UILabel *lb2 = (UILabel *)[self.kemu3putongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        //结业
        if([@1 isEqualToNumber:[tongyongDic objectForKey:@"jy"]]){
            UIImageView *im = (UIImageView *)[self.jieyejishiView viewWithTag:1];
            im.image = [UIImage imageNamed:@"nazheng_blue"];
            UILabel *lb = (UILabel *)[self.jieyejishiView viewWithTag:2];
            lb.textColor = Finish_Color;
            
            UIImageView *im2 = (UIImageView *)[self.jieyeputongView viewWithTag:1];
            im2.image = [UIImage imageNamed:@"nazheng_blue"];
            UILabel *lb2 = (UILabel *)[self.jieyeputongView viewWithTag:2];
            lb2.textColor = Finish_Color;
        }
        
        [Utils removeProgressHUB:self.view];
    } failedBlock:^(NSDictionary *resultDic) {
        
        [Utils removeProgressHUB:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
