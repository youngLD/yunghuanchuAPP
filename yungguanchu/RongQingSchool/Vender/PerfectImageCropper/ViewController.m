//
//  ViewController.m
//  PerfectImageCropperDemo
//
//  Created by Jin Huang on 5/29/13.
//  Copyright (c) 2013 Jin Huang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageCropperView.h"

@interface ViewController ()

@property (nonatomic, retain) IBOutlet ImageCropperView *cropper;
@property (nonatomic, retain) IBOutlet UIImageView *result;
@property (nonatomic, retain) IBOutlet UIButton *btn;

@end

@implementation ViewController
@synthesize cropper, result, btn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    cropper.layer.borderWidth = 1.0;
    cropper.layer.borderColor = [UIColor blueColor].CGColor;
    [cropper setup];
    cropper.image = self.image;
    
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked
{
    if ([btn.currentTitle isEqualToString:@"Crop"]) {
        [cropper finishCropping];
        result.image = cropper.croppedImage;
        cropper.hidden = YES;
        [btn setTitle:@"Back" forState:UIControlStateNormal];
        [btn setTitle:@"Back" forState:UIControlStateHighlighted];
    }else
    {
        [cropper reset];
        cropper.hidden = NO;
        [btn setTitle:@"Crop" forState:UIControlStateNormal];
        [btn setTitle:@"Crop" forState:UIControlStateHighlighted];
        result.image = nil;
    }
}

-(void)popview:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(NSArray*)getRightButtons
{
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [backbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backbtn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitle:@"确定" forState:UIControlStateNormal];
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

@end
