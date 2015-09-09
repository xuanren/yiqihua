//
//  AEEadressList.m
//  ArtExam
//
//  Created by 冬 on 15/2/4.
//  Copyright (c) 2015年 冬. All rights reserved.
//

#import "AEEadressList.h"

@implementation AEEadressList

- (void)getMostRecentEadressList
{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];

    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        self.eadressListArr = [self getObjectsFromNSArray:postsFromResponse];
    }];
}
- (void)getPrevEadressList
{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"rows"];
    [params setValue:@(_mark) forKey:@"page"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.eadressListArr addObjectsFromArray:mutablePosts];
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
        
        AEEadress *colleage = [[AEEadress alloc] initWithAttributes:attributes];
        [mutablePosts addObject:colleage];
    }
    return mutablePosts;
}

@end
