//
//  UINavigationController+NewBackButton.h
//  Diancai
//
//  Created by SarnathAir on 13-10-16.
//  Copyright (c) 2013年 SarnathAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NewBackButton)

-(UIBarButtonItem*)getNewBackButton;

-(NSArray*)getNewBackButtons;

//模态视图的返回按钮
-(NSArray*)getDissmissBackButtonsTarget:(id)target;

//返回按钮，点击事件有对应的control实现
-(NSArray*)getNewBackButtonsTarget:(id)target;

//返回按钮，点击事件有对应的control实现
-(NSArray*)getNewBackButtonsTarget:(id)target selector:(SEL)selector;

//导航栏右按钮
-(NSArray*)getRightButtonsTarget:(id)target;

//返回按钮，点击事件有对应的control实现
-(NSArray*)getRightButtonsTarget:(id)target selector:(SEL)selector;

-(NSArray *)getSmallBackButtonTarget:(id)target selector:(SEL)selector;

//返回一个相应范围比较的返回按钮
-(NSArray*)getSmallBackButtons;

@end
