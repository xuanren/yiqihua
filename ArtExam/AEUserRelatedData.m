//
//  AEUserRelatedData.m
//  ArtExam
//
//  Created by dahai on 14-9-22.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEUserRelatedData.h"

@implementation AEUserRelatedData

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    if (self) {
        
        self.articleNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"articleNum"]];
        self.avatarurl = [att objectForKey:@"avatarurl"];
        self.collegeNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"collegeNum"]];
        self.followerNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"followerNum"]];
        self.followedNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"followedNum"]];
        self.userId = [[att objectForKey:@"id"] intValue];
        self.questionNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"questionNum"]];
        self.roleId = [[att objectForKey:@"roleid"] intValue];
        self.studioNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"studioNum"]];
        self.username = [att objectForKey:@"username"];
        self.verfify = [NSString stringWithFormat:@"%@",[att objectForKey:@"verfify"]];
        self.levelInfo = [att objectForKey:@"levelInfo"];
        self.imageNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"imageNum"]];
     
    }
    
    return self;
}

@end
