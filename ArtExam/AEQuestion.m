//
//  AEQuestion.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEQuestion.h"

@implementation AEQuestion
- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.mydescription = [att objectForKey:@"desc"];
        self.questionId = [[att objectForKey:@"id"] intValue];
        self.pics = [att objectForKey:@"imgs"];
        self.user = [[AETopicUser alloc]initWithAttributes:[att objectForKey:@"user"]];
        
        if ([[att objectForKey:@"marked"] intValue] == 1) {
            self.isMarked = YES;
        }else self.isMarked = NO;
        
        self.subTime = [[att objectForKey:@"subtime"] longLongValue];
        self.score = [[att objectForKey:@"score"] intValue];
    }
    return self;
}
@end
