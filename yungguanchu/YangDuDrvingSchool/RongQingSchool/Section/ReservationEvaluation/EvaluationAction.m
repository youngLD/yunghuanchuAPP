//
//  EvaluationAction.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "EvaluationAction.h"

@implementation EvaluationAction

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0, 0, UISCREEN_SIZE.width, self.bounds.size.height);
    
    CGRect r = self.horPic.frame;
    r.size.width = UISCREEN_SIZE.width;
    self.horPic.frame = r;
    
    r = self.headerBgView.frame;
    r.size.width = UISCREEN_SIZE.width;
    self.headerBgView.frame = r;
    
    r = self.leftBtn.frame;
    r.size.width = UISCREEN_SIZE.width/2;
    self.leftBtn.frame = r;
    
    r = self.rightBtn.frame;
    r.origin.x = UISCREEN_SIZE.width/2;
    r.size.width = UISCREEN_SIZE.width/2;
    self.rightBtn.frame = r;
    
    r = self.verPic.frame;
    r.origin.x = UISCREEN_SIZE.width/2;
    self.verPic.frame = r;

    self.starBgView.center = CGPointMake(self.bounds.size.width/2, self.starBgView.center.y);
    
    
}

-(void)addClickBlock:(EvaluationClickIndexBlock)block{
    self.clickBlock = block;
}

-(IBAction)click:(UIButton *)sender{
    if(self.clickBlock)
        self.clickBlock(sender.tag);
}

-(IBAction)evaluateClick:(UIButton *)sender{
    for(UIButton *btn in self.starBgView.subviews){
        if(btn.tag<=sender.tag){
            [btn setBackgroundImage:[UIImage imageNamed:@"star_full"] forState:UIControlStateNormal];
        }
        else{
            [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
        }
    }
    self.star = (int)sender.tag;
}

-(void)defaultSetting{
    self.star = 0;
    for(UIButton *btn in self.starBgView.subviews){
        [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
    }
}

@end
