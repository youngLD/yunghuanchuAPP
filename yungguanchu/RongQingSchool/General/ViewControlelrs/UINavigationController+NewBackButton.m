//
//  UINavigationController+NewBackButton.m
//  Diancai
//
//  Created by SarnathAir on 13-10-16.
//  Copyright (c) 2013年 SarnathAir. All rights reserved.
//

#import "UINavigationController+NewBackButton.h"

@implementation UINavigationController (NewBackButton)

-(UIBarButtonItem*)getNewBackButton
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 3, 33, 25)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back_button_press"] forState:UIControlStateHighlighted];
    if(IS_IOS7)
        backbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);

    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    return leftitem;
}

-(NSArray*)getNewBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
    
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

//返回按钮，点击事件有对应的control实现
-(NSArray*)getNewBackButtonsTarget:(id)target
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:target action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

//返回按钮，点击事件有对应的control实现
-(NSArray*)getNewBackButtonsTarget:(id)target selector:(SEL)selector
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn setShowsTouchWhenHighlighted:YES];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

-(NSArray *)getSmallBackButtonTarget:(id)target selector:(SEL)selector{
    UIImage *backImg = [UIImage imageNamed:@"back"];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0, backImg.size.width, backImg.size.height)];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    
    
    UIButton *backBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn2.frame = CGRectMake(0.f, -7, backImg.size.width, backImg.size.height);
    [backBtn2 addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:backBtn];
    [backBtnView addSubview:backBtn2];
    
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

-(void)popview:(UIButton *)sender
{
    [self popViewControllerAnimated:YES];
}

//模态视图的返回按钮
-(NSArray*)getDissmissBackButtonsTarget:(id)target
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:target action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"rect_button"] forState:UIControlStateNormal];
    [backbtn setTitle:@"完成" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back_button_press"] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

-(void)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//导航栏右按钮
-(NSArray*)getRightButtonsTarget:(id)target
{
    //导航栏右视图
    UIView *rightNaviBarItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 66, 44)];
    rightNaviBarItem.backgroundColor = [UIColor clearColor];
    
    UIImageView *zhoushouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 17, 17)];
    zhoushouImageView.image = [UIImage imageNamed:@"zhushou"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(34, 12, 32, 17)];
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"助手";
    label.textColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 66, 44);
    [btn addTarget:target action:@selector(showPopMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [rightNaviBarItem addSubview:zhoushouImageView];
    [rightNaviBarItem addSubview:label];
    [rightNaviBarItem addSubview:btn];
    
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:rightNaviBarItem];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
//    [zhoushouImageView release];
//    [label release];
//    [btn release];
//    [rightNaviBarItem release];
    
    return arr;
}

//返回按钮，点击事件有对应的control实现
-(NSArray*)getRightButtonsTarget:(id)target selector:(SEL)selector
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"yxsm"] forState:UIControlStateNormal];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

//返回一个相应范围比较的返回按钮
-(NSArray*)getSmallBackButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(popview:) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    v.backgroundColor = [UIColor clearColor];
    [v addSubview:backbtn];
    
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc] initWithCustomView:v];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    if(IS_IOS7)
        negativeSpacer.width = -7;
    else
        negativeSpacer.width = 3;
    NSArray *arr = [NSArray arrayWithObjects:negativeSpacer,leftitem, nil];
    
    return arr;
}

@end
