//
//  AEColleageIntroList.m
//  ArtExam
//
//  Created by 冬 on 15/2/2.
//  Copyright (c) 2015年 冬. All rights reserved.
//

#import "AEColleageIntroList.h"
#import "AEColleageIntro.h"
@interface AEColleageIntroList ()

@property (strong, nonatomic) NSString *colleageId;

@end

@implementation AEColleageIntroList

- (void)getMostRecentIntroListWihtSid:(NSString *)sid{
    _mark = 1;
    _colleageId = sid;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    if (_colleageId) {
        [params setValue:_colleageId forKey:@"sid"];
    }
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        self.colleageIntroListArr = [self getObjectsFromNSArray:postsFromResponse];
    }];
}
- (void)getPrevIntroList{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    if (_colleageId) {
        [params setValue:_colleageId forKey:@"sid"];
    }
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.colleageIntroListArr addObjectsFromArray:mutablePosts];
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
        
        AEColleageIntro *colleageIntro = [[AEColleageIntro alloc] initWithAttributes:attributes];
        [mutablePosts addObject:colleageIntro];
    }
    return mutablePosts;
}



@end
