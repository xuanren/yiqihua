//
//  AETeacherInfo.m
//  ArtExam
//
//  Created by dahai on 14-9-14.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETeacherInfo.h"

@implementation AETeacherInfo

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    
    if (self) {
        
        self.user = [[AETopicUser alloc] initWithAttributes:att];
        
    }
    
    return self;
}

@end
