//
//  AEAnswerList.m
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEAnswerList.h"
#import "AEAnswer.h"

@implementation AEAnswerList

- (instancetype)initWithAPIName:(NSString *)apiName andQUestionId:(int)qId{
    self = [super initWithAPIName:apiName];
    if (self) {
        self.questionId = qId;
    }
    return self;
}

- (void)getMostRecentAnswers{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:@(self.questionId) forKey:@"qid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"answerList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.answerArr = mutablePosts;
        
        self.question = [[AEQuestion alloc]initWithAttributes:[[JSON objectForKey:@"data"] objectForKey:@"question"]];

    }];
}
- (void)getPrevAnswers{
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    [params setValue:@(self.questionId) forKey:@"qid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"answerList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.answerArr addObjectsFromArray:mutablePosts];
        }
    }];

}

- (void)initBaseInfo:(id)JSON{
    self.timeStamp = [[JSON objectForKey:@"timeStamp"] longLongValue];
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"answerList"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEAnswer *post = [[AEAnswer alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}


@end
