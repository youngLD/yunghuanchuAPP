//
//  NewsTableViewCell.h
//  yunguanchuAPP
//
//  Created by 杨乐栋 on 16/4/19.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *messageDIC;
+(NSString *)IDStr;
@end
