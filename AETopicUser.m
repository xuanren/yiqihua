//
//  AETopicUser.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicUser.h"

//academyname = "";
//avatarurl = "";
//desc = "";
//id = 680;
//position = "";
//qq = "";
//roleid = 1;
//studioname = "";
//username = nihassssso;
//verfify = "";
//weibouid = "";


@implementation AETopicUser

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.academyName = [att objectForKey:@"academyname"];
        self.avatarUrl = [att objectForKey:@"avatarurl"];
        self.mydescription = [att objectForKey:@"desc"];
        self.userId = [[att objectForKey:@"id"] intValue];
        self.studioName = [att objectForKey:@"studioname"];
        self.userName = [att objectForKey:@"username"];
        self.teacherPosition = [[att objectForKey:@"position"] objectForKey:@"name"];
        self.teacherDesc = [att objectForKey:@"desc"];
        
        if ([[att objectForKey:@"verfify"] intValue] == 1) {
            self.isVerified = YES;
        }else self.isVerified = NO;
        
        switch ([[att objectForKey:@"roleid"] intValue]) {
            case 1:
                self.userRole = AEStudent;
                break;
            case 2:
                self.userRole = AETeacher;
                break;
            default:
                self.userRole = AEStudent;
                break;
        }
    }
    return self;
}

@end
