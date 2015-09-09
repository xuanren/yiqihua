//
//  AEUserCenter.m
//  ArtExam
//
//  Created by dahai on 14-9-22.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEUserCenter.h"

@interface AEUserCenter ()

@property (nonatomic) int userId;

@end

@implementation AEUserCenter

- (instancetype)initWithAPIName:(NSString *)apiName andUserId:(int)userId{
    
    self = [super initWithAPIName:apiName];
    if (self) {
        
        self.userId = userId;
    }
    return self;
}

- (void)getUserInfo{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSDictionary *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"user"];
        self.userRelate = [[AEUserRelatedData alloc] initWithAttributes:postsFromResponse];
       
        [[DBNUser sharedDBNUser] setPosition:[postsFromResponse objectForKey:@"position"]];
    }];
}


- (void)initBaseInfo:(id)JSON{
    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"collegeList"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
    if([[JSON objectForKey:@"data"] objectForKey:@"cursor"] != nil) {
        _mark = [[[JSON objectForKey:@"data"] objectForKey:@"cursor"] intValue];
    }
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEUserRelatedData *colleage = [[AEUserRelatedData alloc] initWithAttributes:attributes];
        [mutablePosts addObject:colleage];
    }
    return mutablePosts;
}


@end
