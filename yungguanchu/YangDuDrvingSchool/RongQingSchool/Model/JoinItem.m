//
//  JoinItem.m
//  RongQingSchool
//
//  Created by Hui on 15/9/3.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "JoinItem.h"

@implementation JoinItem
-(id)initWithTitle:(NSString *)title_ withContent:(NSString *)content_ withImage:(NSString *)image_ placeHolder:(NSString *)placeHolder_{
    self = [super init];
    self.title = title_;
    self.content = content_;
    self.image = image_;
    self.placeHolder = placeHolder_;
    return self;
}

-(id)initWithTitle:(NSString *)title_ withContent:(NSString *)content_ withContent1:(NSString *)content1_ withImage:(NSString *)image_ placeHolder:(NSString *)placeHolder_{
    self = [super init];
    self.title = title_;
    self.content = content_;
    self.content1 = content1_;
    self.image = image_;
    self.placeHolder = placeHolder_;
    return self;
}
@end
