//
//  GuideViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/9.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#import "TGViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)gotoMainView:(id)sender{
    [Utils storeGuideViewFinished];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    self.view.transform = CGAffineTransformMakeScale(1.7, 1.7);
    
    [UIView commitAnimations];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = [[TGViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
