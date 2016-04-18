//
//  LoginView.m
//  RongQingSchool
//
//  Created by caitong on 15/8/31.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)clearInputInfo{
    self.userNameTf.text = @"";
    self.passWordTf.text = @"";
}

-(void)addHubProgressView{
    [Utils addProgressHUBInView:self animation:@"loading.gif" delegate:nil];
}

-(void)removeHubProgressView{
    [Utils removeProgressHUB:self];
}

@end
