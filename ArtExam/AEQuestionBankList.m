//
//  AEQuestionBankList.m
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionBankList.h"
#import "AEQuestionBank.h"

@implementation AEQuestionBankList

- (void)getMostRecentQuestionList{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"rows"];
    [params setValue:@(_mark) forKey:@"page"];
    if (_colleageID) {
        [params setValue:_colleageID forKey:@"sid"];
    }
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        self.questionBankAry = [self getObjectsFromNSArray:postsFromResponse];
    }];
}
- (void)getPrevQuestionList{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"rows"];
    [params setValue:@(_mark) forKey:@"page"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.questionBankAry addObjectsFromArray:mutablePosts];
        }
    }];
    
}

- (void)initBaseInfo:(id)JSON{
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEQuestionBank *colleage = [[AEQuestionBank alloc] initWithAttributes:attributes];
        [mutablePosts addObject:colleage];
    }
    return mutablePosts;
}

@end
