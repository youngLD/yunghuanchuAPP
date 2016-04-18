//
//  EvaluationAction3.m
//  RongQingSchool
//
//  Created by Hui on 15/10/25.
//  Copyright © 2015年 荣庆通达驾校. All rights reserved.
//

#import "EvaluationAction1.h"

@implementation EvaluationAction1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    for(UIView *s2 in self.starBgView0.subviews){
        if([s2 isMemberOfClass:[UIView class]]){
            for(UIButton *btn in s2.subviews){
                [btn addTarget:self action:@selector(evaluateClick0:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    for(UIView *s2 in self.starBgView1.subviews){
        if([s2 isMemberOfClass:[UIView class]]){
            for(UIButton *btn in s2.subviews){
                [btn addTarget:self action:@selector(evaluateClick1:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    for(UIView *s2 in self.starBgView2.subviews){
        if([s2 isMemberOfClass:[UIView class]]){
            for(UIButton *btn in s2.subviews){
                [btn addTarget:self action:@selector(evaluateClick2:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    for(UIView *s2 in self.starBgView3.subviews){
        if([s2 isMemberOfClass:[UIView class]]){
            for(UIButton *btn in s2.subviews){
                [btn addTarget:self action:@selector(evaluateClick3:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    for(UIView *s2 in self.starBgView4.subviews){
        if([s2 isMemberOfClass:[UIView class]]){
            for(UIButton *btn in s2.subviews){
                [btn addTarget:self action:@selector(evaluateClick4:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}

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
    
    self.starBgView0.center = CGPointMake(self.bounds.size.width/2, self.starBgView0.center.y);
    self.starBgView1.center = CGPointMake(self.bounds.size.width/2, self.starBgView1.center.y);
    self.starBgView2.center = CGPointMake(self.bounds.size.width/2, self.starBgView2.center.y);
    self.starBgView3.center = CGPointMake(self.bounds.size.width/2, self.starBgView3.center.y);
    self.starBgView4.center = CGPointMake(self.bounds.size.width/2, self.starBgView4.center.y);
    
    self.apgradeBgView.center = CGPointMake(self.bounds.size.width/2, self.apgradeBgView.center.y);
    
}

-(void)addClickBlock:(Evaluation5ClickIndexBlock)block{
    self.clickBlock = block;
}

-(IBAction)apgChange:(UIControl *)sender{
    for(UIView *v in sender.subviews){
        if([v isKindOfClass:[UIImageView class]]){
            [(UIImageView *)v setImage:[UIImage imageNamed:@"select_circle"]];
        }
    }
    
    for(UIView *s in self.apgradeBgView.subviews){
        if(s != sender){
            for(UIView *v in s.subviews){
                if([v isKindOfClass:[UIImageView class]]){
                    [(UIImageView *)v setImage:[UIImage imageNamed:@"unselect_circle"]];
                }
            }
        }
    }
    
    if(sender.tag == 0){
        self.apgString = @"1";
    }else if(sender.tag == 1){
        self.apgString = @"2";
    }else{
        self.apgString = @"3";
    }
}

-(void)evaluateClick0:(UIButton *)sender{
    [self setStarbgImage:self.starBgView0 sender:sender];
    
    self.star0 = (int)sender.tag;
}
-(void)evaluateClick1:(UIButton *)sender{
    [self setStarbgImage:self.starBgView1 sender:sender];
    
    self.star1 = (int)sender.tag;
}
-(void)evaluateClick2:(UIButton *)sender{
    [self setStarbgImage:self.starBgView2 sender:sender];
    
    self.star2 = (int)sender.tag;
}
-(void)evaluateClick3:(UIButton *)sender{
    [self setStarbgImage:self.starBgView3 sender:sender];
    
    self.star3 = (int)sender.tag;
}
-(void)evaluateClick4:(UIButton *)sender{
    [self setStarbgImage:self.starBgView4 sender:sender];
    
    self.star4 = (int)sender.tag;
}

-(void)setStarbgImage:(UIView *)starBgView sender:(UIButton *)sender{
    for(UIView *starView in starBgView.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                if(btn.tag<=sender.tag){
                    [btn setBackgroundImage:[UIImage imageNamed:@"star_full"] forState:UIControlStateNormal];
                }
                else{
                    [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
                }
            }
        }
    }
}

-(IBAction)click:(UIButton *)sender{
    if(self.clickBlock)
        self.clickBlock(sender.tag);
}

-(void)defaultSetting{
    self.star0 = 0;
    self.star1 = 0;
    self.star2 = 0;
    self.star3 = 0;
    self.star4 = 0;
    self.apgString = @"";
    
    for(UIView *starView in self.starBgView0.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
            }
        }
    }
    for(UIView *starView in self.starBgView1.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
            }
        }
    }
    for(UIView *starView in self.starBgView2.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
            }
        }
    }
    for(UIView *starView in self.starBgView3.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
            }
        }
    }
    for(UIView *starView in self.starBgView4.subviews){
        if([starView isMemberOfClass:[UIView class]]){
            for(UIButton *btn in starView.subviews){
                [btn setBackgroundImage:[UIImage imageNamed:@"star_blank"] forState:UIControlStateNormal];
            }
        }
    }
    
    for(UIView *s in self.apgradeBgView.subviews){
        for(UIView *v in s.subviews){
            if([v isKindOfClass:[UIImageView class]]){
                [(UIImageView *)v setImage:[UIImage imageNamed:@"unselect_circle"]];
            }
        }
    }

}

@end
