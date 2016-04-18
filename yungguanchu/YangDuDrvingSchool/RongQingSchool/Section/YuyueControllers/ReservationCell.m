//
//  YuyueCell.m
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ReservationCell.h"

@implementation ReservationCell

- (void)awakeFromNib {
    
//    for(UIView *v in self.contentView.subviews){
//        CGRect r = v.frame;
//        r.origin.x *= WIDTH_SCALE;
//        v.frame = r;
//    }
    
    CGRect r = self.centerBgView.frame;
    r.origin.x *= WIDTH_SCALE;
    self.centerBgView.frame = r;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
