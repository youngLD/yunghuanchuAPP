//
//  ZIKSchoolButton.m
//  yunguanchuAPP
//
//  Created by kong on 16/4/20.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "ZIKSchoolButton.h"

@implementation ZIKSchoolButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = [UIColor yellowColor];
//        [self setImage:[UIImage imageNamed:@"unselectBtnAction"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"selectBtnAction2"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"unselectBtnAction"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"selectBtnAction2"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:3.0/255.0f green:180.0/255.0f blue:248.0/255.0f alpha:1.0f] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return self;
}
-(void)setSchname:(NSString *)Schname {
    _schname = Schname;
    [self setTitle:Schname forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
@end
