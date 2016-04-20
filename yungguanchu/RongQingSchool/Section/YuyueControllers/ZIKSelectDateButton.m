//
//  ZIKSelectDateButton.m
//  yunguanchuAPP
//
//  Created by kong on 16/4/20.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "ZIKSelectDateButton.h"

//#import "UIView+MJExtension.h"

@implementation ZIKSelectDateButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setImage:[UIImage imageNamed:@"rb_sn"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"rb_ss"] forState:UIControlStateSelected];

    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat h = self.frame.size.height-10;
    CGFloat w = h;
    CGFloat x = self.frame.size.width*2/3+5;
    CGFloat y = 5;
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(5, 0, self.frame.size.width*2/3, self.frame.size.height);
}
@end
