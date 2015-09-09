//
//  AETopicList.m
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicList.h"
#import "AETopic.h"
#import "DBNProperties.h"

@implementation AETopicList

- (id)initWithAPIName:(NSString *)apiName{
    NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"quanziList.json"]];
    self = [super initWithAPIName:apiName andFullCachePath:fullCachePath];
    if (self && self.needLoadCache) {
        NSDictionary *json = (NSDictionary *)self.cacheData;
        NSArray *postsFromResponse = [[json objectForKey:@"data"] objectForKey:@"postList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.topicArr = mutablePosts;
    }
    return self;
}

- (void)getMostRecentTopics{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:5] forKey:POSTPAGESIZE];
    [params setValue:@(0) forKey:POSTPAGENUM];
    
    switch (self.type) {
        case AETopicJinghua:
            [params setValue:@(1) forKey:@"type"];
            break;
        case AETopicRecommand:
            [params setValue:@(2) forKey:@"type"];
            break;
            
        default:
            [params setValue:@(self.type) forKey:@"type"];

            break;
    }
    
    [self getCacheDataEntriesWithParameters:params andCacheData:self.needLoadCache andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.topicArr = mutablePosts;
        
    }];

}
- (void)getPrevTopics{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    switch (self.type) {
        case AETopicJinghua:
            [params setValue:@(1) forKey:@"circleId"];
            break;
        case AETopicRecommand:
            [params setValue:@(2) forKey:@"circleId"];
            break;
            
        default:
            [params setValue:@(self.type) forKey:@"circleId"];
            
            break;
    }
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"postList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.topicArr addObjectsFromArray:mutablePosts];
        }
    }];
    

}

- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"postList"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AETopic *post = [[AETopic alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}


- (void)getMyMostRecentTopics:(int)uId{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:@(uId) forKeyPath:@"uid"];
    [params setValue:@"articles" forKeyPath:@"type"];
    
    switch (self.type) {
        case AETopicJinghua:
            [params setValue:@(1) forKey:@"circleId"];
            break;
        case AETopicRecommand:
            [params setValue:@(2) forKey:@"circleId"];
            break;
            
            
        default:
            [params setValue:@(1) forKey:@"circleId"];
            
            break;
    }
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"postList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.topicArr = mutablePosts;
        
    }];

}
    
- (void)getMyPrevTopics:(int)uId{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    [params setValue:@(uId) forKeyPath:@"uid"];
    [params setValue:@"articles" forKeyPath:@"type"];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"postList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.topicArr addObjectsFromArray:mutablePosts];
        }
    }];

}


@end
