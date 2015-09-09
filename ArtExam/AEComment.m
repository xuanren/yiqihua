//
//  AEComment.m
//  ArtExam
//
//  Created by dkllc on 14-9-16.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEComment.h"

@implementation AEComment

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        
        self.user = [[AETopicUser alloc] initWithAttributes:[att objectForKey:@"user"]];
        
        if ([att objectForKey:@"origuser"]) {
            
            self.origUser = [[AETopicUser alloc] initWithAttributes:[att objectForKey:@"origuser"]];
        }
        
        self.picArr = [att objectForKey:@"imgs"];
        
        self.content = [att objectForKey:@"content"];
        self.origcommentDic = [att objectForKey:@"origcomment"];
        self.origuid = [[att objectForKey:@"origuid"] intValue];
        self.postid = [[att objectForKey:@"postid"] intValue];
        self.subtime = [[att objectForKey:@"subtime"] longLongValue];
        self.commentId = [[att objectForKey:@"id"] intValue];
    }
    return self;
}

@end
