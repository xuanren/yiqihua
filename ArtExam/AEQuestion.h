//
//  AEQuestion.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AETopicUser.h"

@interface AEQuestion : NSObject

@property (nonatomic, strong) AETopicUser *user;
@property (nonatomic, strong) NSString *mydescription;
@property (nonatomic) int questionId;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic) int score;
@property (nonatomic) BOOL isMarked;
@property (nonatomic) long long subTime;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
