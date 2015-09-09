//
//  AETopic.h
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AETopicUser.h"
#import "AECircle.h"

@interface AETopic : NSObject

@property (nonatomic) int circleId;
@property (nonatomic) int commentNum;
@property (nonatomic) int pvNum;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) int topicId;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic) int phraiseNum;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) AETopicUser *user;
@property (nonatomic) BOOL upToTop;
@property (nonatomic) long long subtime;
@property (nonatomic) BOOL isPhraised;
@property (nonatomic) BOOL isFavorited;
@property (nonatomic) int postType;//0普通，1精华，2置顶，3活动，4公告
@property (nonatomic, strong) AECircle *circle;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
