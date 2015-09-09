//
//  AEColleageList.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEColleageList.h"

@interface AEColleageList ()

@property (nonatomic) int userId;

@end

@implementation AEColleageList

- (instancetype)initWithAPIName:(NSString *)apiName andDetailId:(NSString *)collegeId{
    
    self = [super initWithAPIName:apiName];
    if (self) {
        
        self.collegeId = collegeId;
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

- (instancetype)initWithAPIName:(NSString *)apiName andLocationId:(int)locationId{
    
    self = [super initWithAPIName:apiName];
    if (self) {
        
        self.locationId = locationId;
    }
    return self;
}
- (void)getMostRecentSchools{
    _mark = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
   
    if (_locationId > 0) {
        
        [params setValue:[NSNumber numberWithInt:_locationId] forKey:@"locationId"];
    }
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] valueForKey:@"collegeList"];
        self.schoolList = [self getObjectsFromNSArray:postsFromResponse];
    }];
}

//更多院校
- (void)getPrevSchools{
    if (_mark == 1) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
    [params setValue:@(_mark) forKey:POSTPAGENUM];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        _mark++;
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"collegeList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.schoolList addObjectsFromArray:mutablePosts];
        }
    }];
    
}

- (void)getSchoolDetail{
    
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"pageSize"];
    [params setValue:@(0) forKey:@"pageNumber"];
    [params setValue:_collegeId forKey:@"sid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSDictionary *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"college"];
        self.collegeDetail = [[AEColleage alloc] initWithAttributes:postsFromResponse];
    }];
}

-(NSString*)EncodeUTF8Str:(NSString*)encodeStr{
    
    CFStringRef nonAlphaNumValidChars = CFSTR("![DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    
    NSString *preprocessedString = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""),kCFStringEncodingUTF8));
    
    NSString *newStr = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8));
    
    return newStr;
    
}


- (void)getSearchCollectListsForKey:(NSString *)key{
    
    _mark = 0;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
//    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:POSTPAGESIZE];
//    [params setValue:@(0) forKey:POSTPAGENUM];
    [params setValue:key forKey:@"pname"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"collegeList"];
        self.schoolList = [self getObjectsFromNSArray:postsFromResponse];
    }];
}

- (void) getMostRecentMyCollegeList{
    
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:@"colleges" forKeyPath:@"type"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"collegeList"];
        self.schoolList = [self getObjectsFromNSArray:postsFromResponse];
    }];
}

- (void)getMostCollectCollegeList{
    
    _mark = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(0) forKey:@"cursor"];
    [params setValue:@"colleges" forKeyPath:@"type"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"dataList"];
        self.schoolList = [self getObjectsFromNSArray:postsFromResponse];
    }];
}

- (void) getPrevMyCollegeList{
    
    if (_mark == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:[NSNumber numberWithInt:self.entryCount] forKey:@"num"];
    [params setValue:@(_mark) forKey:@"cursor"];
    [params setValue:[NSString stringWithFormat:@"%d",_userId] forKeyPath:@"uid"];
    [params setValue:@"colleges" forKeyPath:@"type"];
    
    [self getDataEntriesWithParameters:params andMethord:@"POST" completion:^(id JSON) {
        [self initBaseInfo:JSON];
        
        NSArray *postsFromResponse = [[JSON objectForKey:@"data"] objectForKey:@"collegeList"];
        NSMutableArray *mutablePosts = [self getObjectsFromNSArray:postsFromResponse];
        if (mutablePosts != nil) {
            [self.schoolList addObjectsFromArray:mutablePosts];
        }
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
        
        AEColleage *colleage = [[AEColleage alloc] initWithAttributes:attributes];
        [mutablePosts addObject:colleage];
    }
    return mutablePosts;
}



@end
