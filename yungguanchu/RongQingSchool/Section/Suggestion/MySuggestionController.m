//
//  MySuggestionController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/6.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "MySuggestionController.h"

@interface MySuggestionController ()

@end

@implementation MySuggestionController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self.hidesBottomBarWhenPushed = YES;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"投诉建议";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    [self initView];
}

-(void)initView{
    UIView *hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_SIZE.width, 44)];
    UIView *suv = [[UIView alloc] initWithFrame:hiddenView.frame];
    suv.backgroundColor = [UIColor blackColor];
    suv.alpha = 0.2;
    [hiddenView addSubview:suv];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(UISCREEN_SIZE.width-59, 7, 52, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hiddenKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [hiddenView addSubview:btn];
    
    self.inputTv.inputAccessoryView = hiddenView;
    
    self.inputTv.delegate = self;
    
    self.placeholderLb.backgroundColor = [UIColor clearColor];
    self.placeholderLb.font = [UIFont systemFontOfSize:14];
    self.placeholderLb.textColor = UIColorFromRGB(220, 220, 220);
    self.placeholderLb.hidden = NO;
}

-(IBAction)requestData{
    if([Utils isNullOrEmpty:self.textField.text] || [Utils isNullOrEmpty:self.inputTv.text]){
        [Utils showMessage:@"suggestionCanNotEmpty"];
        return;
    }
    NSDictionary *postParam = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UserInfo shareUserInfo].uId,@"comid",
                               self.textField.text,@"comobject",
                               self.inputTv.text,@"comcontent",nil];
    
    self.request = [[WebRequest alloc] init];
    [Utils addProgressHUBInView:self.view textInfo:@"loading" delegate:nil];
    [self.request requestGetWithAction:Action_AppComplain WithParameter:postParam successBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
        [Utils showMessage:@"suggestionSuccess"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failedBlock:^(NSDictionary *resultDic) {
        [Utils removeProgressHUB:self.view];
    }];
}

-(IBAction)hiddenKeyboard:(id)sender{
    [self.inputTv resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView{
    if([@"" isEqualToString:textView.text]){
        self.placeholderLb.hidden = NO;
    }
    else{
        self.placeholderLb.hidden = YES;
    }
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
