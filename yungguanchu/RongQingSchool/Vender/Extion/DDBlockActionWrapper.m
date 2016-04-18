//
//  DDBlockActionWrapper.m
//  RongQingSchool
//
//  Created by caitong on 15/10/13.
//  Copyright © 2015年 荣庆通达驾校. All rights reserved.
//

#import "DDBlockActionWrapper.h"

@implementation DDBlockActionWrapper
@synthesize blockAction;
- (void) dealloc {
    [self setBlockAction:nil];
}

- (void) invokeBlock:(id)sender {
    [self blockAction]();
}

@end


@implementation UIControl (DDBlockActions)

static const char * UIControlDDBlockActions = "unique";

- (void) addEventHandler:(void(^)(void))handler
        forControlEvents:(UIControlEvents)controlEvents {
    
    NSMutableArray * blockActions =
    objc_getAssociatedObject(self, &UIControlDDBlockActions);
    
    if (blockActions == nil) {
        blockActions = [NSMutableArray array];
        objc_setAssociatedObject(self, &UIControlDDBlockActions,
                                 blockActions, OBJC_ASSOCIATION_RETAIN);
    }
    
    DDBlockActionWrapper * target = [[DDBlockActionWrapper alloc] init];
    [target setBlockAction:handler];
    [blockActions addObject:target];
    
    [self addTarget:target action:@selector(invokeBlock:) forControlEvents:controlEvents];
    
}

@end
