//
//  AEMatriculateList.h
//  ArtExam
//
//  Created by Zhengen on 15-6-10.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEMatriculateList.h"
#import "AEMatriculate.h"

@interface AEMatriculateList ()
@property (strong, nonatomic) NSString *colleageID;
@end

@implementation AEMatriculateList

- (void)getMostRecentMatriculateListWihtSid:(NSString *)sid{
    _mark = 1;
	_colleageID = sid;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(_mark) forKey:@"pageNumber"];
    if (_colleageID) {
        [params setValue:_colleageID forKey:@"sid"];
    }
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark ++;
//        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
        
        //liubo 修改
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        self.matriculateAry = [self getObjectsFromNSArray:postsFromResponse];
    }];
}
- (void)getPrevMatriculateList{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(_mark) forKey:@"pageNumber"];
    
	if (_colleageID) {
        [params setValue:_colleageID forKey:@"sid"];
    }

    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
//        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
        
        //liubo 修改
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.matriculateAry addObjectsFromArray:mutablePosts];
        }
    }];
}

- (void)initBaseInfo:(id)JSON{
//    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
    
    
    //liubo 修改
    NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEMatriculate *matriculate = [[AEMatriculate alloc] initWithAttributes:attributes];
        [mutablePosts addObject:matriculate];
    }
    return mutablePosts;
}

@end