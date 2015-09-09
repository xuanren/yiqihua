//
//  AEAnswer.m
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEAnswer.h"

@implementation AEAnswer

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.content = [att objectForKey:@"remark"];
        self.commentId = [[att objectForKey:@"id"] intValue];
        self.user = [[AETopicUser alloc]initWithAttributes:[att objectForKey:@"user"]];
        self.subTime = [[att objectForKey:@"subtime"] longLongValue];
        self.score = [[att objectForKey:@"score"] intValue];
    }
    return self;
}


@end
