//
//  AECircle.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECircle.h"

@implementation AECircle

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        
        self.circieLd = [[att objectForKey:@"id"] intValue];
        self.name = [att objectForKey:@"name"];
        self.mydescription = [att objectForKey:@"desc"];
        
//        NSArray *tmpArr = [att objectForKey:@"icon"];
//        if ([tmpArr count] > 0) {
//            NSDictionary *tmp = [tmpArr objectAtIndex:0];
//            self.imgUrl = [tmp objectForKey:@"url"];
//        }
        
        self.imgUrl = [att objectForKey:@"url"];
        
    }
    return self;
}

@end
