//
//  ReturnMoneyAction.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ReturnMoneyAction.h"

@implementation ReturnMoneyAction

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    self.inputTv.inputAccessoryView = self.inputAccessView;
    
    UIView *hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 44)];
    UIView *suv = [[UIView alloc] initWithFrame:hiddenView.frame];
    suv.backgroundColor = [UIColor whiteColor];
    suv.alpha = 0.2;
    [hiddenView addSubview:suv];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(UISCREEN_SIZE.width-59, 7, 52, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hiddenKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [hiddenView addSubview:btn];
    
    self.inputTv.inputAccessoryView = hiddenView;
    
    self.inputTv.delegate = self;
    
    self.placeholderLb = [[UILabel alloc] initWithFrame:CGRectMake(2, 5, 140, 21)];
    self.placeholderLb.backgroundColor = [UIColor clearColor];
    self.placeholderLb.font = [UIFont systemFontOfSize:14];
    self.placeholderLb.textColor = UIColorFromRGB(190, 190, 190);
    self.placeholderLb.text = self.placeholderText;
    [self.inputTv addSubview:self.placeholderLb];
    self.placeholderLb.hidden = NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.bounds;
    r.size.width = UISCREEN_SIZE.width;
    self.bounds = r;
    
    r = self.headerBgView.frame;
    r.size.width = self.bounds.size.width;
    self.headerBgView.frame = r;
    
    r = self.inputTv.frame;
    r.size.width = self.bounds.size.width-r.origin.x*2;
    self.inputTv.frame = r;
    
    r = self.cancleBtn.frame;
    r.origin.x = 0;
    r.size.width = self.bounds.size.width/2;
    self.cancleBtn.frame = r;
    
    r = self.okBtn.frame;
    r.origin.x = UISCREEN_SIZE.width/2;
    r.size.width = self.bounds.size.width/2;
    self.okBtn.frame = r;
    
    r = self.line3.frame;
    r.origin.x = UISCREEN_SIZE.width/2;
    self.line3.frame = r;
    
    r = self.line1.frame;
    r.size.width = self.bounds.size.width;
    self.line1.frame = r;
    
    r = self.line2.frame;
    r.size.width = self.bounds.size.width;
    self.line2.frame = r;
    
    self.inputTv.text = @"";
}

-(void)addClickBlock:(ReturnMoneyClickIndexBlock)block{
    self.clickBlock = block;
}

-(IBAction)click:(UIButton *)sender{
    if(self.clickBlock)
        self.clickBlock(sender.tag);
}

-(IBAction)hiddenKeyboard:(id)sender{
    [self.inputTv resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView{
    if([@"" isEqualToString:textView.text]){
        self.placeholderLb.hidden = NO;
    }
    else{
        self.placeholderLb.hidden = YES;
    }
}

@end
