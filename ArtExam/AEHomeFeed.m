//
//  AEHomeFeed.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEHomeFeed.h"

@implementation AEHomeFeed

- (id)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.feedId = [att objectForKey:@"id"];
        NSString *coverStr = [att objectForKey:@"cover"]; //封面id （加载图片和下载是需用到）
        self.picUrl = [[ROOTURL stringByAppendingString:IMGURL] stringByAppendingString:coverStr];
        self.mydescription = [att objectForKey:@"title"];
        self.feedType = [att objectForKey:@"type"];
        self.typeId = [att objectForKey:@"id"];
        self.viewNum = [att objectForKey:@"views"];
    }
    return self;
}

@end
