//
//  NewsTableViewCell.m
//  yunguanchuAPP
//
//  Created by 杨乐栋 on 16/4/19.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 43.5, [UIScreen mainScreen].bounds.size.width-20, 0.5)];
        [lineView setBackgroundColor:[UIColor colorWithRed:188/255.f green:188/255.f blue:188/255.f alpha:1]];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:lineView];
    }
    return self;
}
+(NSString *)IDStr
{
    return @"NewsTableViewCell";
}
-(void)setMessageDIC:(NSDictionary *)messageDIC
{
    self.textLabel.text=[messageDIC objectForKey:@""];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
