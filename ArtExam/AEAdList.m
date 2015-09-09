//
//  AEAdList.m
//  ArtExam
//
//  Created by dahai on 14-10-8.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEAdList.h"
#import "DBNProperties.h"

@interface AEAdList ()

@property (nonatomic) int type;

@end

@implementation AEAdList

- (id)initWithAPIName:(NSString *)apiName{
    NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"adList.json"]];
    self = [super initWithAPIName:apiName andFullCachePath:fullCachePath];
    if (self) {
        NSDictionary *json = (NSDictionary *)self.cacheData;
        NSArray *postsFromResponse = [[json objectForKey:@"data"] objectForKey:@"adlist"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        self.adAry = mutablePosts;
    }
    return self;
}

- (id)initWithAPIName:(NSString*)apiName andFrom:(int)type{
    
    self = [self initWithAPIName:apiName];
    if (self) {
        
        self.type = type;
    }
    return self;
}

- (void)getadList{
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
//    [params setValue:@(0) forKey:@"cursor"];
//    [params setValue:@(_type) forKeyPath:@"from"];
    
//    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
//
//        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"adlist"];
//        self.adAry = [self getObjectsFromNSArray:postsFromResponse];
//        
//        
//    }];
    
    [self getCacheDataEntriesWithParameters:params andCacheData:YES andMethord:@"POST" completion:^(id JSON) {
        
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        self.adAry = [self getObjectsFromNSArray:postsFromResponse];
    }];
    
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        AEAdvertisement *post = [[AEAdvertisement alloc] initWithAttributes:attributes];
        if (self.type == 0)
        {
            if ([post.typeName isEqualToString:@"画室广告"])
                [mutablePosts addObject:post];
        }
        else
        {
            [mutablePosts addObject:post];
        }
    }
    return mutablePosts;
}

@end
