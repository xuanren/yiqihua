//
//  AEWorkSetList.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkSetList.h"
#import "AEWorkSet.h"
#import "DBNProperties.h"

@implementation AEWorkSetList

- (id)initWithAPIName:(NSString *)apiName{
    NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"albums.json"]];
    self = [super initWithAPIName:apiName andFullCachePath:fullCachePath];
    if (self) {
        NSDictionary *json = (NSDictionary *)self.cacheData;
        NSArray *postsFromResponse = [[json objectForKey:@"data"] objectForKey:@"albums"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.workSetArr = mutablePosts;
    }
    return self;
}

- (void)getMostRecentWorkSets{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(0) forKey:POSTPAGENUM];
    
    switch (self.myType) {
        case AETopicJinghua:
            [params setValue:@(1) forKey:@"type"];
            break;
        case AETopicRecommand:
            [params setValue:@(2) forKey:@"type"];
            break;
            
        default:
            [params setValue:@(1) forKey:@"type"];
            break;
    }
    __block AEWorkSetList *blockSelf = self;
    [self getCacheDataEntriesWithParameters:params andCacheData:YES andMethord:@"POST" completion:^(id JSON) {
        
        [blockSelf initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mutablePosts = [blockSelf getObjectsFromNSArray:postsFromResponse];
        if (blockSelf.myType == AETopicJinghua) {
            blockSelf.workSetArr = mutablePosts;
        }else if (blockSelf.myType == AETopicRecommand){
            blockSelf.workSetArrRecommand = mutablePosts;
        }
        
    }];
    
    
}
- (void)getPrevWorkSets{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    switch (self.myType) {
        case AETopicJinghua:
            [params setValue:@(1) forKey:@"type"];
            break;
        case AETopicRecommand:
            [params setValue:@(2) forKey:@"type"];
            break;
            
        default:
            [params setValue:@(1) forKey:@"type"];
            break;
    }
    
    __block AEWorkSetList *blockSelf = self;
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            if (blockSelf.myType == AETopicJinghua) {
                
                [blockSelf.workSetArr addObjectsFromArray:mutablePosts];
            }else if (blockSelf.myType == AETopicRecommand){
                
                [blockSelf.workSetArrRecommand addObjectsFromArray:mutablePosts];
            }
        }
    
    }];
}

- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"albums"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEWorkSet *post = [[AEWorkSet alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}

@end
