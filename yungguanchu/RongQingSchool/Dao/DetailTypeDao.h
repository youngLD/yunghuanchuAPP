//
//  DetailTypeDao.h
//  RongQingSchool
//
//  Created by Hui on 15/9/5.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "BaseDao.h"

@interface DetailTypeDao : BaseDao

//章节练习
-(NSMutableArray *)selectAllChapter:(SubjectType)type;

//我的收藏章节列表
-(NSMutableArray *)selectMyCollectionChapter:(SubjectType)type;

//我的错题章节列表
-(NSMutableArray *)selectMyWrongChapter:(SubjectType)type;

//未做练习题章节列表
-(NSMutableArray *)selectNeverDoChapter:(SubjectType)type;

@end
