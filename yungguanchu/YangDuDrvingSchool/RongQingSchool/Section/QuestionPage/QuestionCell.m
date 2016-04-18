//
//  QuestionCell.m
//  RongQingSchool
//
//  Created by caitong on 15/8/20.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "QuestionCell.h"
#import "AnswerCell.h"
#import "QuestionAnswerItem.h"
#import "QuestionLibraryDao.h"
#define AnswerMagin 28
#define AnswerFont [UIFont systemFontOfSize:16]
#define AnswerDefalutColor UIColorFromRGB(102,102,102)
#define AnswerCurrectColor UIColorFromRGB(3, 180, 248)
#define AnswerWrongColor UIColorFromRGB(241,92,92)

@implementation QuestionCell

-(void)awakeFromNib{
    self.cellNib = [UINib nibWithNibName:@"AnswerCell" bundle:nil];
    [self.tableView registerNib:self.cellNib forCellReuseIdentifier:@"cellid"];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    self.bgScrollView.delaysContentTouches = NO;
    
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.borderColor = UIColorFromRGB(200,200,200).CGColor;
    self.tableView.layer.borderWidth = 0.5;
    
    self.questionTextLbBgView.layer.cornerRadius = 4;
    self.questionTextLbBgView.layer.borderColor = UIColorFromRGB(200,200,200).CGColor;
    self.questionTextLbBgView.layer.borderWidth = 0.5;

    CGRect r = self.bgScrollView.frame;
    r.size.height = UISCREEN_SIZE.height - 64 - 45;
    self.bgScrollView.frame = r;
}

-(void)vedioPlay:(NSString *)videoName{
    NSURL *sourceMovieURL = [[NSBundle mainBundle] URLForResource:videoName withExtension:@"mp4"];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    if(!self.player){
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.player.allowsExternalPlayback = NO;
        self.playerView.player = _player;
        [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
        CLog(@"构建AVPlayer");
    }
    else{
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
    }
    
    
    [self.playerView.player play];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)runLoopTheMovie:(NSNotification *)n{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK
    
    AVPlayerItem * p = [n object];
    //关键代码
    [p seekToTime:kCMTimeZero];
    
    [_player play];
}

-(void)reloadQuestion{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionAnswerItem *item = self.dataAry[indexPath.row];
    //根据str计算label实际大小
    NSString *answer = item.answer;
    if([item.answer hasPrefix:@"A、"] ||
       [item.answer hasPrefix:@"B、"] ||
       [item.answer hasPrefix:@"C、"] ||
       [item.answer hasPrefix:@"D、"] ||
       [item.answer hasPrefix:@"E、"] ||
       [item.answer hasPrefix:@"F、"] ||
       [item.answer hasPrefix:@"G、"])
    {
        answer = [item.answer substringFromIndex:2];
    }
    CGSize labelSize = [answer sizeWithFont:AnswerFont
                          constrainedToSize:CGSizeMake(tableView.frame.size.width-50, 1000)
                              lineBreakMode:NSLineBreakByWordWrapping];
    return AnswerMagin+labelSize.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bgBtn.tag = indexPath.row;
    [cell.bgBtn addTarget:self action:@selector(cellDidClick:) forControlEvents:UIControlEventTouchUpInside];
    if(IS_IOS7){
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if(IS_IOS8){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    QuestionAnswerItem *item = self.dataAry[indexPath.row];
    
    
    //分析该答案是否是正确答案
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *resultAnswerAry = [self.questionItem.answerId componentsSeparatedByString:@";"];
        BOOL isItemTheCurrect = NO;
        if(self.questionItem.option_type == 2){
            if([self.questionItem.answer isEqualToString:item.answer]){
                isItemTheCurrect = YES;
            }
        }
        else{
            for(NSString *answerOne in resultAnswerAry){
                if([item.uid rangeOfString:answerOne].length > 4){
                    isItemTheCurrect = YES;
                    break;
                }
            }
        }
        
        item.isTheCurrect = isItemTheCurrect;
    });
    
    //根据str计算label实际大小
    NSString *answer = item.answer;
    if([item.answer hasPrefix:@"A、"] ||
       [item.answer hasPrefix:@"B、"] ||
       [item.answer hasPrefix:@"C、"] ||
       [item.answer hasPrefix:@"D、"] ||
       [item.answer hasPrefix:@"E、"] ||
       [item.answer hasPrefix:@"F、"] ||
       [item.answer hasPrefix:@"G、"])
    {
        answer = [item.answer substringFromIndex:2];
    }
    [Utils autoHeightLabel2:cell.answerLb withString:answer
                   setFrame:CGRectMake(44, 3, tableView.frame.size.width-50, 1000)
                       font:AnswerFont];
    
    //答案
    CGRect r = cell.answerLb.frame;
    r.origin.y = ((AnswerMagin+cell.answerLb.frame.size.height/*cell高度*/)-r.size.height)/2;
    cell.answerLb.frame = r;
    cell.answerLb.textColor = AnswerDefalutColor;
    cell.selectBgView1.frame = cell.bounds;
    
    //回答结果处理
    cell.selectBgView1.hidden = !item.isSelected;
    if(self.questionItem.isSelected){
        if(item.isTheCurrect){
            cell.headPic.image = [UIImage imageNamed:@"answer_status_currect"];
            cell.abcdLb.hidden = YES;
            cell.answerLb.textColor = AnswerCurrectColor;
        }
        else if(!item.isTheCurrect && item.isSelected){
            cell.headPic.image = [UIImage imageNamed:@"answer_status_wrong"];
            cell.abcdLb.hidden = YES;
            cell.answerLb.textColor = AnswerWrongColor;
        }
        else{
            cell.headPic.image = [UIImage imageNamed:@"question_status_default"];
            cell.abcdLb.hidden = NO;
            cell.answerLb.textColor = AnswerDefalutColor;
        }
    }
    else{
        //多选
        if(self.questionItem.option_type == 1){
            if(item.isSelected){
                cell.headPic.image = [UIImage imageNamed:@"answer_status_green"];
                cell.answerLb.textColor = AnswerDefalutColor;
            }
            else{
                cell.headPic.image = [UIImage imageNamed:@"question_status_default"];
                cell.answerLb.textColor = AnswerDefalutColor;
            }
        }
        else{
            cell.headPic.image = [UIImage imageNamed:@"question_status_default"];
            cell.answerLb.textColor = AnswerDefalutColor;
        }
        cell.abcdLb.hidden = NO;
    }
    
    //ABCD
    CGPoint o = cell.abcdBgView.center;
    o.y = (AnswerMagin+cell.answerLb.frame.size.height/*cell高度*/)/2;
    cell.abcdBgView.center = o;
    cell.abcdLb.text = [NSString stringWithFormat:@"%c",(char)indexPath.row+65];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    /*
    //如果是非多选，并且还未选择
    if(self.questionItem.option_type != 1 && !self.questionItem.isSelected){
    
        self.questionItem.isSelected = YES;
        QuestionAnswerItem *item = self.dataAry[indexPath.row];
        item.isSelected = YES;
        
        //判断题
        if([@"0" isEqualToString:self.questionItem.answerId] || [@"1" isEqualToString:self.questionItem.answerId]){
            
            if(item.isTheCurrect){
                self.resultLb.text = @"答对了😄";
                self.questionItem.optionStatus = 1;
            }
            else{
                self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                self.questionItem.optionStatus = 0;
            }
        }
        //单选
        else{
            if(item.isTheCurrect){
                self.resultLb.text = @"答对了😄";
                self.questionItem.optionStatus = 1;
            }
            else{
                self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                self.questionItem.optionStatus = 0;
            }
        }
        
        [self recordDatabase];
        
        [self.delegate didQuestionFinished:self.questionItem];
        
        [tableView reloadData];
    }
    //多选
    else if(self.questionItem.option_type == 1){
        if(!self.questionItem.isSelected){
            QuestionAnswerItem *item = self.dataAry[indexPath.row];
            item.isSelected = !item.isSelected;
            
            AnswerCell *cell = (AnswerCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selectBgView1.hidden = !item.isSelected;
            if(item.isSelected){
                cell.headPic.image = [UIImage imageNamed:@"answer_status_green"];
            }
            else{
                cell.headPic.image = [UIImage imageNamed:@"question_status_default"];
            }
        }
        
    }
    */
}

-(void)cellDidClick:(UIButton *)sender{
    //如果是非多选，并且还未选择
    if(self.questionItem.option_type != 1 && !self.questionItem.isSelected){
        
        self.questionItem.isSelected = YES;
        QuestionAnswerItem *item = self.dataAry[sender.tag];
        item.isSelected = YES;
        
        //判断题
        if([@"0" isEqualToString:self.questionItem.answerId] || [@"1" isEqualToString:self.questionItem.answerId]){
            
            if(item.isTheCurrect){
                self.resultLb.text = @"答对了😄";
                self.questionItem.optionStatus = 1;
            }
            else{
                self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                self.questionItem.optionStatus = 0;
            }
        }
        //单选
        else{
            if(item.isTheCurrect){
                self.resultLb.text = @"答对了😄";
                self.questionItem.optionStatus = 1;
            }
            else{
                self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                self.questionItem.optionStatus = 0;
            }
        }
        
        [self recordDatabase];
        
        [self.delegate didQuestionFinished:self.questionItem];
        
        [self.tableView reloadData];
    }
    //多选
    else if(self.questionItem.option_type == 1){
        if(!self.questionItem.isSelected){
            QuestionAnswerItem *item = self.dataAry[sender.tag];
            item.isSelected = !item.isSelected;
            
            AnswerCell *cell = (AnswerCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:sender.tag inSection:0]];
            cell.selectBgView1.hidden = !item.isSelected;
            if(item.isSelected){
                cell.headPic.image = [UIImage imageNamed:@"answer_status_green"];
            }
            else{
                cell.headPic.image = [UIImage imageNamed:@"question_status_default"];
            }
        }
        
    }
}

-(IBAction)commitMultiQuestion:(UIButton *)sender{
    //是否已经做过了题目
    if(!self.questionItem.isSelected){
        //是否选择了
        NSInteger selectCount = 0;
        for(QuestionAnswerItem *item in self.dataAry){
            if(item.isSelected){
                selectCount ++;
            }
        }
        
        if(selectCount>1){
            self.questionItem.isSelected = YES;
            
            NSArray *resultAnswerAry = [self.questionItem.answerId componentsSeparatedByString:@";"];
            if(resultAnswerAry.count == selectCount){
                //默认为正确的
                BOOL currect = YES;
                
                for(NSString *ss in resultAnswerAry){
                    //正确答案中的一项
                    NSString * sss = [NSString stringWithFormat:@"{%@}",ss];
                    
                    //默认为没有相同的id
                    BOOL haveSame = NO;
                    
                    for(QuestionAnswerItem *item in self.dataAry){
                        
                        //寻找在选择的答案中是否有正确答案
                        if(item.isSelected){
                            if([sss isEqualToString:item.uid]){
                                //经判断有相同的id,则该选择正确
                                haveSame = YES;
                                break;
                            }
                        }
                        
                    }
                    
                    //该选择确证，进行下一轮比较，否则该题目就可以断定为选择错误
                    if(haveSame){
                        continue;
                    }
                    else{
                        currect = NO;
                        break;
                    }
                }
                
                if(currect){
                    self.resultLb.text = @"答对了😄";
                    self.questionItem.optionStatus = 1;
                    
                }
                else{
                    self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                    self.questionItem.optionStatus = 0;
                }
            }
            else{
                self.resultLb.text = [NSString stringWithFormat:@"答错了😭。正确答案：%@",self.questionItem.answer];
                self.questionItem.optionStatus = 0;
            }
            [self recordDatabase];
            
            [self.delegate didQuestionFinished:self.questionItem];
            
            [self.tableView reloadData];
        }
        else{
            [Utils showMessage:@"请选择至少两项"];
        }
    }
    else{
        [Utils showMessage:@"已经做过了"];
    }
    
    
}

-(void)recordDatabase{
    
    QuestionLibraryDao *dao = [[QuestionLibraryDao alloc] init];
    [dao openDataBase];
    [dao recordAnswerdQuestion:self.questionItem];
    [dao closeDataBase];
    
}

-(void)dealloc{
    CLog(@"销毁一个AVPlayer");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [self.playerView.player pause];
}

@end
