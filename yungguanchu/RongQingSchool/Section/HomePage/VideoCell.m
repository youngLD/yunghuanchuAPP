//
//  VideoCell.m
//  RongQingSchool
//
//  Created by caitong on 15/9/21.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    CGRect r = self.videoBtn.frame;
    r.size.width = (UISCREEN_SIZE.width-30)/2;
    self.videoBtn.frame = r;
    
    r = self.titleLb.frame;
    r.size.width = (UISCREEN_SIZE.width-30)/2;
    self.titleLb.frame = r;
    
    r = self.markBtn.frame;
    r.origin.x = (UISCREEN_SIZE.width-30)/2-r.size.width+3;
    self.markBtn.frame = r;
    
    r = self.timeLb.frame;
    r.origin.x = (UISCREEN_SIZE.width-30)/2-r.size.width - 10;
    self.timeLb.frame = r;
}

@end
