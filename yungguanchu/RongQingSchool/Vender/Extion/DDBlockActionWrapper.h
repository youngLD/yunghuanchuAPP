//
//  DDBlockActionWrapper.h
//  RongQingSchool
//
//  Created by caitong on 15/10/13.
//  Copyright © 2015年 荣庆通达驾校. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface DDBlockActionWrapper : NSObject
@property (nonatomic, copy) void (^blockAction)(void);
- (void) invokeBlock:(id)sender;
@end
