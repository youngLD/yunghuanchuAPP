//
//  CoashSelectAction.m
//  RongQingSchool
//
//  Created by caitong on 15/9/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "CoachSelectAction.h"

@implementation CoachSelectAction

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
    
    if([Utils isNullOrEmpty:self.leftBtn.titleLabel.text]){
        r = self.leftBtn.frame;
        r.size.width = 0;
        self.leftBtn.frame = r;
        
        r = self.rightBtn.frame;
        r.origin.x = 0;
        r.size.width = UISCREEN_SIZE.width;
        self.rightBtn.frame = r;
        
        r = self.verPic.frame;
        r.origin.x = 0;
        r.size.width = 0;
        self.verPic.frame = r;
    }
    else{
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
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 0;
    [self exchangeContent:btn];
}

-(IBAction)exchangeContent:(UIButton *)sender{
    self.selectedTag = sender.tag;
    if(sender.tag == 0){
        self.headPic1.image = [UIImage imageNamed:@"select_circle"];
        self.headPic2.image = [UIImage imageNamed:@"unselect_circle"];
    }else{
        self.headPic2.image = [UIImage imageNamed:@"select_circle"];
        self.headPic1.image = [UIImage imageNamed:@"unselect_circle"];
    }
}

-(void)addClickBlock:(ClickIndexBlock)block{
    self.clickBlock = block;
}

-(IBAction)click:(UIButton *)sender{
    if(self.clickBlock)
        self.clickBlock(sender.tag,self.selectedTag);
}

@end
