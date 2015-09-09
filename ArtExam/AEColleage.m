//
//  AEColleage.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEColleage.h"

@implementation AEColleage

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    if (self) {
        self.colleageId = [att objectForKey:@"id"];
        self.name = [att objectForKey:@"name"];
        self.imgs = [att objectForKey:@"images"];
        self.locationArea = [att objectForKey:@"province"];
        self.buildYear = [att objectForKey:@"year"];
        self.collegeType = [att objectForKey:@"type"];
        self.colleageLevel = [att objectForKey:@"level"];
        self.colleageSubject = [att objectForKey:@"subject"];
        self.colleageStunum = [att objectForKey:@"stunum"];
        self.viewNum = [att objectForKey:@"views"];
        /*
        self.collegeType = [att objectForKey:@"collegetype"];
        self.descId = [att objectForKey:@"descid"];
        self.edulevel = [att objectForKey:@"level"];
        self.examId = [att objectForKey:@"examid"];
        self.examSubject = [att objectForKey:@"examsubject"];
        self.idStr = [att objectForKey:@"id"];
        self.locationId = [att objectForKey:@"locationid"];
        self.recruitId = [att objectForKey:@"recruitid"];
        self.specId = [att objectForKey:@"specid"];
        self.startTime = [NSString stringWithFormat:@"%@",[att objectForKey:@"starttime"]];
        self.studentNum = [NSString stringWithFormat:@"%@",[att objectForKey:@"studentnum"]];
        
        self.albumid = [NSString stringWithFormat:@"%@",[att objectForKey:@"albumid"]];
        self.location = [att objectForKey:@"location"];
        self.wantreadNum = [[att objectForKey:@"wantreadNum"] intValue];
        self.isFavorite = [[att objectForKey:@"isFavorite"] intValue];
         */
    }
    
    return self;
}

@end
