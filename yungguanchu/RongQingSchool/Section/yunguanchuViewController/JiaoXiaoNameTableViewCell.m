//
//  JiaoXiaoNameTableViewCell.m
//  yunguanchuAPP
//
//  Created by 杨乐栋 on 16/4/19.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "JiaoXiaoNameTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface JiaoXiaoNameTableViewCell ()
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *detialLab;
@end
@implementation JiaoXiaoNameTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=frame;
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 70, 50)];
        [self.contentView addSubview:self.imageV];
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(90, 15, 130, 20)];
        [self.titleLab setFont:[UIFont systemFontOfSize:15]];
        [self.titleLab setTextColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:self.titleLab];
        self.detialLab=[[UILabel alloc]initWithFrame:CGRectMake(100, 35, 190, 18)];
        [self.detialLab setFont:[UIFont systemFontOfSize:13]];
        [self.detialLab setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.detialLab];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, frame.size.height-0.5, [UIScreen mainScreen].bounds.size.width-20, 0.5)];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [lineView setBackgroundColor:[UIColor colorWithRed:188/255.f green:188/255.f blue:188/255.f alpha:1]];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        [self.contentView addSubview:lineView];
    }
    return self;
}
+(NSString *)IDStr
{
    return @"JiaoXiaoNameTableViewCell";
}
-(void)setInfoDic:(NSDictionary *)InfoDic
{
    _InfoDic=InfoDic;
    self.detialLab.text=[InfoDic objectForKey:@"schoolAddress"];
    self.titleLab.text=[InfoDic objectForKey:@"schoolName"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[InfoDic objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"MoRentu"]];
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
