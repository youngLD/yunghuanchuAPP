//
//  KaoshiYuyueCell.m
//  RongQingSchool
//
//  Created by caitong on 15/8/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "ExamReservationCell.h"

@implementation ExamReservationCell

- (void)awakeFromNib {
    CGRect r = self.contentView2.frame;
    r.size.width = UISCREEN_SIZE.width;
    self.contentView2.frame = r;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
