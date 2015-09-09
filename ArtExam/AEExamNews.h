//
//  AEExamNews.h
//  ArtExam
//
//  Created by Zheng'en on 15-5-12.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEExamNews : NSObject

//资讯id
@property (nonatomic, strong) NSString *newsId;
//资讯标题
@property (nonatomic, strong) NSString *newsTitle;
//资讯封面
@property (nonatomic, strong) NSString *newsCover;
//资讯内容
@property (nonatomic, strong) NSString *newsContont;
//排序编号
@property (nonatomic) int newsMorder;
//资讯状态
@property (nonatomic) BOOL isHidden;
//资讯创建日期
@property (nonatomic, strong) NSDate *newsCreateDate;
//日期格式
@property (nonatomic, strong) NSString *dateString;
//创建用户ID
@property (nonatomic, strong) NSString *createUserId;
//创建用户名字
@property (nonatomic, strong) NSString *createUserName;
//资讯浏览量
@property (nonatomic, strong) NSString *newsViews;
//资讯分类
@property (nonatomic, strong) NSString *newsType;
//分类名称
@property (nonatomic, strong) NSString *typeName;
//资讯图片
@property (nonatomic, strong) NSArray *newsImgs;

@property (nonatomic) BOOL isFavorite;


- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
