//
//  AEExamNewsList.m
//  ArtExam
//
//  Created by Zheng'en on 15-5-12.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEExamNewsList.h"

@interface AEExamNewsList ()

@property (nonatomic) int userId;

@end

@implementation AEExamNewsList

- (void)getMostRecentExamNews{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(_mark) forKey:@"pageNumber"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark++;
        
//        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] valueForKey:@"beanName"];
        
        //liubo 修改
        NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
        
        
        self.examNewsList = [NSMutableArray arrayWithArray:[self getObjectsFromNSArray:postsFromResponse]];
        
        
        //liubo 添加
//        if (self.resultBlock) {
//            self.resultBlock(self.examNewsList);
//        }
        
    }];
    
    
}

- (void)getMostRecentExamNewsWithSuccess:(void (^)(id))result
{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(_mark) forKey:@"pageNumber"];

    // liubo 改动
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] valueForKey:@"beanName"];
        self.examNewsList = [self getObjectsFromNSArray:postsFromResponse];
        
//        if (result) {
//            result(self.examNewsList);
//        }
    }];
}

//更多资讯
- (void)getPrevExamNews{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(_mark) forKey:@"pageNumber"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.examNewsList addObjectsFromArray:mutablePosts];
        }
    }];
    
}

- (void)getExamNewsDetail{
    
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(0) forKey:@"pageNumber"];
    [params setValue:_examNewsId forKey:@"sid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSDictionary *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
        self.examNewsDetail = [[AEExamNews alloc] initWithAttributes:postsFromResponse];
    }];
}

- (void)initBaseInfo:(id)JSON{
    //liubo 修改
    NSArray *postsFromResponse = [JSON objectForKey:@"rows"];
//    NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"beanName"];
    self.noMoreEntry = [postsFromResponse count] < self.entryCount ? YES : NO;
}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AEExamNews *examNews = [[AEExamNews alloc] initWithAttributes:attributes];
        [mutablePosts addObject:examNews];
    }
    return mutablePosts;
}



@end
