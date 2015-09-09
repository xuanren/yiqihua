//
//  AEQuestionList.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEQuestionList.h"
#import "AEQuestion.h"
#import "DBNProperties.h"

@interface AEQuestionList ()

@property (nonatomic) int userId;

@end
@implementation AEQuestionList

- (id)initWithAPIName:(NSString *)apiName{
    NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"questionList.json"]];
    self = [super initWithAPIName:apiName andFullCachePath:fullCachePath];
    if (self) {
        NSDictionary *json = (NSDictionary *)self.cacheData;
        NSArray *postsFromResponse = [[json objectForKey:@"data"] objectForKey:@"questionList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        
        self.questionArr = mutablePosts;
        
        _timeStamp = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

- (instancetype)initWithAPIName:(NSString *)apiName andUserId:(int)userId{
    
    self = [super initWithAPIName:apiName];
    if (self) {
       
        self.userId = userId;
    }
    return self;
}

- (void)getMostRecentQuestions{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:YES andMethord:@"POST" completion:^(id JSON) {
                
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"questionList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.questionArr = mutablePosts;
        
    }];

}
- (void)getPrevQuestions{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
                
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"questionList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.questionArr addObjectsFromArray:mutablePosts];
        }
    }];
    

}

- (void)getMostRecentMyQuestionList{
    
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"questionList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.questionArr = mutablePosts;
        
    }];
}

- (void)getPrevMyQuestionList{
    
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:NO andMethord:@"POST" completion:^(id JSON) {
        
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"questionList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.questionArr addObjectsFromArray:mutablePosts];
        }
    }];
}

- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"questionlist"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEQuestion *post = [[AEQuestion alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}


@end
