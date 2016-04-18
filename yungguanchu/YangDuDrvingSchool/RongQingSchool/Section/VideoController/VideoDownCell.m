//
//  VideoDownCell.m
//  RongQingSchool
//
//  Created by caitong on 15/9/23.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "VideoDownCell.h"
#import "UIButton+EnlargeArea.h"

@implementation VideoDownCell

- (void)awakeFromNib {
    [self.actionBtn setEnlargeEdgeWithTop:20 right:5 bottom:20 left:10];
}

//进度条的代理
- (void)setProgress:(float)newProgress {
    [self.delegate setProgress:newProgress cell:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
