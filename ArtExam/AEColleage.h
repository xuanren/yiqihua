//
//  AEColleage.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEColleage : NSObject
/*
 @property (nonatomic, strong) NSString *descId;
 @property (nonatomic, strong) NSString *edulevel;
 @property (nonatomic, strong) NSString *examId;
 @property (nonatomic, strong) NSString *examSubject;
 @property (nonatomic, strong) NSString *idStr;
 @property (nonatomic, strong) NSString *locationId;
 @property (nonatomic, strong) NSString *popularity;
 @property (nonatomic, strong) NSString *recruitId;
 @property (nonatomic, strong) NSString *specId;
 @property (nonatomic, strong) NSString *startTime;
 @property (nonatomic, strong) NSString *albumid;
 @property (nonatomic, strong) NSDictionary *location;
 @property (nonatomic) int wantreadNum;
*/

//学校id
@property (nonatomic, strong) NSString *colleageId;
//学校名称
@property (nonatomic, strong) NSString *name;
//学校环境
@property (nonatomic, strong) NSArray *imgs;
//地区
@property (nonatomic, strong) NSString *locationArea;
//创办年份
@property (nonatomic, strong) NSString *buildYear;
//学院类型
@property (nonatomic, strong) NSString *collegeType;
//学历层次
@property (nonatomic, strong) NSString *colleageLevel;
//考美科目
@property (nonatomic, strong) NSString *colleageSubject;
//招生人数
@property (nonatomic, strong) NSString *colleageStunum;
//人气值
@property (nonatomic, strong) NSString *viewNum;

@property (nonatomic) BOOL isFavorite;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
