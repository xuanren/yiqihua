//
//  AEStudio.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEStudio.h"

@implementation AEStudio

- (instancetype)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.address = [att objectForKey:@"address"];
        self.studioId = [[att objectForKey:@"id"] intValue];
        self.mydescription = [att objectForKey:@"desc"];
        self.picArr = [att objectForKey:@"imgs"];
        self.locationId = [[[att objectForKey:@"location"] objectForKey:@"id"] intValue];
        self.locationName = [[att objectForKey:@"location"] objectForKey:@"name"];
        self.name = [att objectForKey:@"name"];
        self.popular = [[att objectForKey:@"popularity"] intValue];
        self.scale = [[att objectForKey:@"scale"] intValue];
        self.startTime = [att objectForKey:@"starttime"];
        self.phone = [att objectForKey:@"tel"];
        self.popularity = [[att objectForKey:@"popularity"] longLongValue];
        self.isFavorite = [[att objectForKey:@"isFavorite"] intValue];
    }
    return self;
}
@end
