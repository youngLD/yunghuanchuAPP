//
//  TablePickerView.m
//  RongQingSchool
//
//  Created by Hui on 15/9/3.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "TablePickerView.h"

@implementation TablePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    if(self.frame.size.height > 300){
        self.frame = CGRectMake(0, self.superview.frame.size.height-300, UISCREEN_SIZE.width, 300);
    }
    self.tableView.frame = self.bounds;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    return self;
}

-(void)addBloci:(TableClickAtIndexBlock)block{
    self.clickBlock = block;
}

-(void)reloadTableView{
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, UISCREEN_SIZE.width, 20)];
        lb.tag = 10;
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor = UIColorFromRGB(102, 102, 102);
        lb.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:lb];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(IS_IOS7){
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if(IS_IOS8){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    UILabel *lb = (UILabel *)[cell viewWithTag:10];
    lb.text = [self.dataAry objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.clickBlock(indexPath.section,indexPath.row);
}

@end
