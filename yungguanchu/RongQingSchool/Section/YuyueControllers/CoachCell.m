//
//  CoachCell.m
//  RongQingSchool
//
//  Created by caitong on 15/9/1.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "CoachCell.h"

@implementation CoachCell

- (void)awakeFromNib {
    self.hourTimeAry = @[self.hour0TimeLb,
                         self.hour1TimeLb,
                         self.hour2TimeLb,
                         self.hour3TimeLb,
                         self.hour4TimeLb,
                         self.hour5TimeLb,
                         self.hour6TimeLb,
                         self.hour7TimeLb];
    
    self.hourMarkAry = @[self.hour0MarkLb,
                         self.hour1MarkLb,
                         self.hour2MarkLb,
                         self.hour3MarkLb,
                         self.hour4MarkLb,
                         self.hour5MarkLb,
                         self.hour6MarkLb,
                         self.hour7MarkLb];
    
    self.hourTimeBtnAry = @[self.hour0TimeBtn,
                            self.hour1TimeBtn,
                            self.hour2TimeBtn,
                            self.hour3TimeBtn,
                            self.hour4TimeBtn,
                            self.hour5TimeBtn,
                            self.hour6TimeBtn,
                            self.hour7TimeBtn];
    
    self.priceAry = @[self.price0TimeLb,
                      self.price1TimeLb,
                      self.price2TimeLb,
                      self.price3TimeLb,
                      self.price4TimeLb,
                      self.price5TimeLb,
                      self.price6TimeLb,
                      self.price7TimeLb
                      ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
