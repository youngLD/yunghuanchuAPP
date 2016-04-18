//
//  SettingCarType.m
//  RongQingSchool
//
//  Created by caitong on 15/9/9.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "SettingCarType.h"

@implementation SettingCarType

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [self defaultSetting];
}

-(void)awakeFromNib{
    self.controls = @[self.ctrl0,self.ctrl1,self.ctrl2,self.ctrl3];
    self.ctrl3.userInteractionEnabled=NO;
    [self defaultSetting];
}

-(IBAction)click:(UIControl *)sender{
    for(UIControl *ctrl in self.controls){
        if(ctrl == sender){
            for(UIView *sv in ctrl.subviews){
                if([sv.class isSubclassOfClass:[UIImageView class]]){
                    if(sv.tag == 10){
                        ((UIImageView *)sv).image = [UIImage imageNamed:@"select_circle"];
                    }
                    
                }
            }
            self.selectedIndex = ctrl.tag;
        }
        else{
            for(UIView *sv in ctrl.subviews){
                if([sv.class isSubclassOfClass:[UIImageView class]]){
                    if(sv.tag == 10){
                        ((UIImageView *)sv).image = [UIImage imageNamed:@"unselect_circle"];
                    }
                    
                }
            }
        }
    }
    
//    [self closeSelf];
}

-(void)defaultSetting{
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:key_user_selected_car_type];
    if(!i) i = 0;
    
    for(UIControl *ctrl in self.controls){
        if(ctrl.tag == i){
            for(UIView *sv in ctrl.subviews){
                if([sv.class isSubclassOfClass:[UIImageView class]]){
                    if(sv.tag == 10){
                        ((UIImageView *)sv).image = [UIImage imageNamed:@"select_circle"];
                    }
                    
                }
            }
            [[NSUserDefaults standardUserDefaults] setInteger:i forKey:key_user_selected_car_type];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            for(UIView *sv in ctrl.subviews){
                if([sv.class isSubclassOfClass:[UIImageView class]]){
                    if(sv.tag == 10){
                        ((UIImageView *)sv).image = [UIImage imageNamed:@"unselect_circle"];
                    }
                    
                }
            }
        }
    }
}

-(void)addClickBlock:(ClickIndexBlock1)block{
    self.clickBlock = block;
}

-(IBAction)closeSelf{
    self.clickBlock(0);
    [[NSUserDefaults standardUserDefaults] setInteger:self.selectedIndex forKey:key_user_selected_car_type];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(IBAction)removeSelf:(id)sender{
    self.clickBlock(0);
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:key_user_selected_car_type];
    if(!i) i = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:i forKey:key_user_selected_car_type];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
