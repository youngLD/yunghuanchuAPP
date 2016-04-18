//
//  HiddenTextField.m
//  caipiao
//
//  Created by caitong on 15/1/3.
//  Copyright (c) 2015年 caitong. All rights reserved.
//

#import "HiddenTextField.h"

@implementation HiddenTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if(!self.inputAccessoryView){
        UIView *accessView = [[[NSBundle mainBundle] loadNibNamed:@"HiddenTextFieldAccessView" owner:self options:nil] lastObject];
        UIButton *doneBtn = (UIButton *)[accessView viewWithTag:1];
        [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        
        self.inputAccessoryView = accessView;
    }
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIView *accessView = [[[NSBundle mainBundle] loadNibNamed:@"HiddenTextFieldAccessView" owner:self options:nil] lastObject];
        UIButton *doneBtn = (UIButton *)[accessView viewWithTag:1];
        [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        
        self.inputAccessoryView = accessView;
    }
    
    return self;
}



-(id)init{
    self = [super init];
    if(self){
        UIView *accessView = [[[NSBundle mainBundle] loadNibNamed:@"HiddenTextFieldAccessView" owner:self options:nil] lastObject];
        UIButton *doneBtn = (UIButton *)[accessView viewWithTag:1];
        [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        
        self.inputAccessoryView = accessView;
    }
    
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 5 , 5 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 5 , 5 );
}

-(void)hideKeyboard{
    [self resignFirstResponder];
}

@end
