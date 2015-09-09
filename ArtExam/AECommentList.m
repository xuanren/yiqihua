//
//  AECommentList.m
//  ArtExam
//
//  Created by dkllc on 14-9-16.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECommentList.h"
#import "AEComment.h"

@implementation AECommentList
- (instancetype)initWithAPIName:(NSString *)apiName andPostId:(int)pId{
    self = [super initWithAPIName:apiName];
    if (self) {
        self.postId = pId;
    }
    return self;
}

- (void)getMostRecentComments{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:5] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:@(self.postId) forKey:@"postId"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"commentList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.commentArr = mutablePosts;
        
        self.topic = [[AETopic alloc]initWithAttributes:[[JSON objectForKey:@"data"] objectForKey:@"post"]];
        
    }];

}
- (void)getPrevComments{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    [params setValue:@(self.postId) forKey:@"postId"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"commentList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.commentArr addObjectsFromArray:mutablePosts];
        }
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
        
        AEComment *post = [[AEComment alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}


@end
