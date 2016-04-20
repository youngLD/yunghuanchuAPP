//
//  ZIKMenu2View.m
//  yunguanchuAPP
//
//  Created by kong on 16/4/20.
//  Copyright © 2016年 荣庆通达驾校. All rights reserved.
//

#import "ZIKMenu2View.h"
#import "ZIKSchoolButton.h"
#import "ZIKSelectDateButton.h"

static NSInteger schoolButtonY;
@interface ZIKMenu2View ()
{
    UIScrollView  *bgView;
    //NSInteger schoolButtonY;
}
@end
@implementation ZIKMenu2View

-(instancetype)initWithFrame:(CGRect)frame withSchoolArray:(NSArray *)schoolArr
{
    if (self = [super initWithFrame:frame]) {

        bgView = [[UIScrollView alloc] init];
        bgView.frame = CGRectMake(0, 0, UISCREEN_SIZE.width, UISCREEN_SIZE.height*2/3);
        bgView.contentSize = CGSizeMake(bgView.frame.size.width, UISCREEN_SIZE.height);
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        //bgView.frame = frame;
        UILabel *hint1Label = [[UILabel alloc] init];
        //hint1Label.backgroundColor = [UIColor redColor];
        hint1Label.frame = CGRectMake(15, 10, 60, 25);
        hint1Label.text = @"驾校:";
        hint1Label.textColor = [UIColor darkGrayColor];
        [bgView addSubview:hint1Label];

        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = CGRectGetMaxY(hint1Label.frame)+5;//用来控制button距离父视图的高
        CGFloat wplus = 25;

        for (int i = 0; i<schoolArr.count; i++) {
            ZIKSchoolButton *button = [[ZIKSchoolButton alloc] init];
            button.tag = 100+i;
            button.selected = YES;
            //button自适应宽度
            //根据计算文字的大小
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};

            NSDictionary *dic = schoolArr[i];
            NSString *string = dic[@"Schname"];
            CGFloat length = [string boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //设置button的frame
            button.frame = CGRectMake(25 + w, h, length + wplus , 30);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(25 + w + length + wplus > UISCREEN_SIZE.width-50){
                w = 0; //换行时将w置为0
                h = h + button.frame.size.height + 8;//距离父视图也变化
                button.frame = CGRectMake(25 + w, h, length + wplus,30);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            button.schname = dic[@"Schname"];
            button.schid   = dic[@"Schid"];
            [bgView addSubview:button];
            [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];

            if (i == schoolArr.count - 1) {

                UIView *lineView = [[UIView alloc] init];
                lineView.frame = CGRectMake(15, CGRectGetMaxY(button.frame)+10, UISCREEN_SIZE.width-30, 0.7);
                lineView.backgroundColor = [UIColor lightGrayColor];
                [bgView addSubview:lineView];
                schoolButtonY = CGRectGetMaxY(lineView.frame)+10;
            }
        }

        UILabel *hint2Label = [[UILabel alloc] init];
        hint2Label.frame = CGRectMake(15, schoolButtonY, 60, 25);
        hint2Label.text = @"日期:";
        hint2Label.textColor = [UIColor darkGrayColor];
        [bgView addSubview:hint2Label];

//        for (int i = 0; i < 3; i++) {
//            ZIKSelectDateButton *button  = [[ZIKSelectDateButton alloc] init];
//            [button addTarget:self action:@selector(selectDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [bgView addSubview:button];
//        }

        UIButton *screenButton = [[UIButton alloc] init];
        screenButton.frame = CGRectMake(60, bgView.frame.size.height-90, UISCREEN_SIZE.width-120, 40);
        [screenButton setTitle:@"提交筛选" forState:UIControlStateNormal];
        [screenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:screenButton];
        [screenButton setBackgroundColor:[UIColor colorWithRed:3/255.0 green:180/255.0 blue:248/255.0 alpha:1]];
        [screenButton addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];



    }
    return self;
}

- (void)setTimeArr:(NSArray *)timeArr {
    _timeArr = timeArr;
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[ZIKSelectDateButton class]]) {
//            //[view removeFromSuperview];
//            return;
//        }
//    }
    for (int i = 0; i < 3; i++) {
        ZIKSelectDateButton *button  = [[ZIKSelectDateButton alloc] init];
        button.tag = 200+i;
        button.selected = YES;
        button.frame  = CGRectMake(60, schoolButtonY+35+i*30, 140, 25);
        [button setTitle:[NSString stringWithFormat:@"%@",timeArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];

    }
}

- (void)selectDateBtnClick:(UIButton*)button {
    button.selected = !button.selected;
}

- (void)btn:(UIButton *)button {
    button.selected = !button.selected;
    CLog(@"%d",button.selected);
}

- (void)screenBtnClick {
    CLog(@"提交筛选按钮点击");
    __block NSString *schoolString = @"";
    __block NSString *orderdateString = @"";
    [bgView.subviews enumerateObjectsUsingBlock:^(UIView *myview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([myview isKindOfClass:[ZIKSchoolButton class]]) {
            ZIKSchoolButton *button = (ZIKSchoolButton *)myview;
            if (button.selected) {
                schoolString = [schoolString stringByAppendingFormat:@"%@|",button.schid];
            }
        }
        if ([myview isKindOfClass:[ZIKSelectDateButton class]] ) {
            ZIKSelectDateButton *button = (ZIKSelectDateButton *)myview;
            if (button.selected) {
                //[orderdateString stringByAppendingString:[NSString stringWithFormat:@"%@|",button.currentTitle]];
             orderdateString =    [orderdateString stringByAppendingFormat:@"%@|",button.currentTitle];
                CLog(@"%@",button.currentTitle);
            }
        }
    }];
    if ([schoolString isEqualToString:@""]) {
        CLog(@"ss:%@",schoolString);
    }
    else {
        schoolString = [schoolString substringToIndex:schoolString.length-1];
    }
    if ([orderdateString isEqualToString:@""]) {
        CLog(@"orS:%@",orderdateString);
    }
    else {
    //CLog(@"%lu",(unsigned long)orderdateString.length);
    NSUInteger hint = (NSUInteger)orderdateString.length-1;
   orderdateString = [orderdateString substringToIndex:hint];
    CLog(@"%@",orderdateString);
    }
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [infoDic setObject:schoolString forKey:@"school"];
    [infoDic setObject:orderdateString forKey:@"orderdate"];
    if ([self.delegate respondsToSelector:@selector(sendSchoolAndDateInfo:)]) {
        [self.delegate sendSchoolAndDateInfo:infoDic];
    }

}



@end
