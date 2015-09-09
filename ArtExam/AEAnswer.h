//
//  AEAnswer.h
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AETopicUser.h"

@interface AEAnswer : NSObject

@property (nonatomic, strong) AETopicUser *user;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) int score;
@property (nonatomic) long long subTime;
@property (nonatomic) int commentId;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
