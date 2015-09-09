//
//  AETopic.m
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopic.h"

@implementation AETopic

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.circleId = [[att objectForKey:@"circleid"] intValue];
        self.commentNum = [[att objectForKey:@"commentNum"] intValue];
        self.content = [att objectForKey:@"content"];
        self.topicId = [[att objectForKey:@"id"] intValue];
        self.picArr = [att objectForKey:@"images"];
        self.phraiseNum = [[att objectForKey:@"praiseNum"] intValue];
        self.subtime = [[att objectForKey:@"subtime"] longLongValue];
        self.title = [att objectForKey:@"title"];
        self.user = [[AETopicUser alloc]initWithAttributes:[att objectForKey:@"user"]];
        if ([[att objectForKey:@"top"] intValue] == 1) {
            self.upToTop = YES;
        }else{
            self.upToTop = NO;
        }
        
        if ([[att objectForKey:@"isPraise"] intValue] == 1) {
            self.isPhraised = YES;
        }else{
            self.isPhraised = NO;
        }
        
        if ([[att objectForKey:@"isFavorite"] intValue] == 1) {
            self.isFavorited = YES;
        }else{
            self.isFavorited = NO;
        }
        
        self.circle = [[AECircle alloc]initWithAttributes:[att objectForKey:@"circle"]];
        
        self.postType = [[att objectForKey:@"type"] intValue];
        
        self.pvNum = [[att objectForKey:@"pv"] intValue];
    }
    return self;
}

@end
