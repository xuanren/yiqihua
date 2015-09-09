//
//  AECircleList.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECircleList.h"
#import "AECircle.h"

@implementation AECircleList


- (void)getAllCircles{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"circleList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.circleArr = mutablePosts;
        
    }];

}

- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"commentList"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AECircle *post = [[AECircle alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}


@end
