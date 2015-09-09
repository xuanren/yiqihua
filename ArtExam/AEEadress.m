//
//  AEEadress.m
//  ArtExam
//
//  Created by 冬 on 15/2/4.
//  Copyright (c) 2015年 冬. All rights reserved.
//

#import "AEEadress.h"

@implementation AEEadress

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.eadressID = [att objectForKey:@"id"];
        self.eadressTitle = [att objectForKey:@"title"];
    };
    return self;
}

@end
