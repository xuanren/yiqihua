//
//  AEQuestionBank.m
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionBank.h"

@implementation AEQuestionBank

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    if (self) {
        
        self.idStr = [att objectForKey:@"id"];
        self.subtime = [[att objectForKey:@"subtime"] longLongValue];
        self.title = [att objectForKey:@"title"];
        self.type = [att objectForKey:@"type"];
    }
    return self;
}


@end
