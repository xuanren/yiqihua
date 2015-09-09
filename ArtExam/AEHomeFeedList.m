//
//  AEHomeFeedList.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEHomeFeedList.h"
#import "AEHomeFeed.h"
#import "DBNProperties.h"
#import "DBNStatusView.h"

@implementation AEHomeFeedList

- (id)initWithAPIName:(NSString *)apiName{
    NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"indexPage.json"]];
    self = [super initWithAPIName:apiName andFullCachePath:fullCachePath];
    if (self) {
        NSDictionary *json = (NSDictionary *)self.cacheData;
        NSArray *postsFromResponse = [[json objectForKey:@"data"] objectForKey:@"feedlist"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.feedArr = mutablePosts;
    }
    return self;
}

/**
 *  获取列表
 */
- (void)getMostRecentHomeFeeds{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:YES andMethord:@"POST" completion:^(id JSON) {
#ifdef DEBUG
        NSLog(@"getHomeList:%@",JSON);
#endif
        _mark ++;
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.feedArr = mutablePosts;
    }];

}

/**
 *  加载更多
 */
- (void)getPrevHomeFeeds{
    
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
#ifdef DEBUG
        NSLog(@"getHomeList:%@",JSON);
#endif
        _mark ++;
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.feedArr addObjectsFromArray:mutablePosts];
        }        
    }];
}

/*
- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"feedlist"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"rows"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}
 
 */

CDDFIX
- (void)initBaseInfo:(id)JSON
{
   // self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
}


- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEHomeFeed *post = [[AEHomeFeed alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}



@end
