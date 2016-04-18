//
//  CoashSelectAction.h
//  RongQingSchool
//
//  Created by caitong on 15/9/26.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIndexBlock)(NSInteger index, NSInteger selectedTag);

@interface CoachSelectAction : UIView

@property(strong,nonatomic) IBOutlet UIImageView *headPic1;
@property(strong,nonatomic) IBOutlet UIImageView *headPic2;

@property(strong,nonatomic) IBOutlet UIButton *leftBtn;

@property(strong,nonatomic) IBOutlet UIButton *rightBtn;

@property(strong,nonatomic) IBOutlet UIImageView *horPic;

@property(strong,nonatomic) IBOutlet UIImageView *verPic;

@property(nonatomic) NSInteger selectedTag;

@property(strong,nonatomic) ClickIndexBlock clickBlock;

-(void)addClickBlock:(ClickIndexBlock)block;



@end
