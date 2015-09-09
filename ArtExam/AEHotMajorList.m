//
//  AEHotMajorList.m
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEHotMajorList.h"
#import "AEHotMajor.h"

@implementation AEHotMajorList

- (void)getMostRecentHotMajorList{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"rows"];
    [params setValue:@(_mark) forKey:@"page"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        self.hotMajorAry = [self getObjectsFromNSArray:postsFromResponse];
    }];
}
- (void)getPrevHotMajorList{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"rows"];
    [params setValue:@(_mark) forKey:@"page"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.hotMajorAry addObjectsFromArray:mutablePosts];
        }
    }];
}

- (void)initBaseInfo:(id)JSON{
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEHotMajor *hotMajor = [[AEHotMajor alloc] initWithAttributes:attributes];
        [mutablePosts addObject:hotMajor];
    }
    return mutablePosts;
}

@end
