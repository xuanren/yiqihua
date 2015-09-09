//
//  AEAdvertisement.m
//  ArtExam
//
//  Created by dahai on 14-10-8.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEAdvertisement.h"

@implementation AEAdvertisement

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    if (self) {
        
        self.imgUrl = [[ROOTURL stringByAppendingString:IMGURL]stringByAppendingString:[att objectForKey:@"cover"]];
        self.descStr = [att objectForKey:@"title"];
        self.albumid = [[att objectForKey:@"id"] intValue];
        self.subtime = [[att objectForKey:@"subtime"] longLongValue];
        self.tid = [att objectForKey:@"id"];
        self.type = [att objectForKey:@"type"];
        self.typeName = [att objectForKey:@"typename"];
    }
    return self;
}

@end
