//
//  DBNCachedDataEntries.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/12/13.
//
//

#import "DBNCachedDataEntries.h"
#import "DBNProperties.h"
#import "JSON.h"
#import "DBNAPIClient.h"
#import "DBNStatusView.h"
#import "DBNStrings.h"

@implementation DBNCachedDataEntries

@synthesize cacheData = _cacheData;
@synthesize cachePath = _cachePath;

- (id)initWithAPIName:(NSString *)apiName cachePath:(NSString*)name {
    self = [super initWithAPIName:apiName];
    if(self) {
        self.cachePath = name;
        self.fullCachePath = nil;
        NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] dbnInfoCachePath]
                                        stringByAppendingPathComponent:self.cachePath];
        NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:fullCachePath
                                                            encoding:NSUTF8StringEncoding error:nil];
        if(jsonStr) {
            self.cacheData = [jsonStr JSONValue];
            [jsonStr release];
        }
    }
    return self;
}

- (id)initWithAPIName:(NSString *)apiName andFullCachePath:(NSString*)path{
    self = [super initWithAPIName:apiName];
    if(self) {
        self.fullCachePath = path;
        NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:self.fullCachePath
                                                            encoding:NSUTF8StringEncoding error:nil];
        if(jsonStr) {
            self.cacheData = [jsonStr JSONValue];
            [jsonStr release];
        }
    }
    return self;

}

- (void)saveCacheData {
    if(self.cacheData != nil) {
        NSString *jsonStr = [self.cacheData JSONRepresentation];
        if (self.fullCachePath != nil) {
            [jsonStr writeToFile:self.fullCachePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            return;
        }
        NSString *fullCachePath = [[[DBNProperties sharedDBNProperties] dbnInfoCachePath]
                                   stringByAppendingPathComponent:self.cachePath];
        [jsonStr writeToFile:fullCachePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}


- (void)getCacheDataEntriesWithParameters:(NSMutableDictionary *)params andCacheData:(BOOL)cache andMethord:(NSString *)methord completion:(void (^)(id))result{
    if ([methord isEqualToString:@"GET"]) {
        self.isLoading = YES;
        [[DBNAPIClient sharedClient] getPath:self.apiName
                                  parameters:params
                                  needIdInfo:NO
                                     success:^(AFHTTPRequestOperation *operation, id JSON) {
                                         self.isLoading = NO;
#ifdef DEBUG
                                         NSLog(@"接口：（%@）:%@",self.apiName,JSON);
#endif

                                         if ([[JSON objectForKey:@"code"] intValue] != 0) {
                                             NSLog(@"[%@]:%@",self.apiName,[JSON objectForKey:@"error"]);
                                             if(self.delegate) {
                                                 [self.delegate dataEntries:self LoadError:[JSON objectForKey:@"error"]];
                                             }
                                             return ;
                                         }
                                         
                                         if (result) {
                                             result(JSON);
                                         }
                                         
                                         if (cache) {
                                             self.cacheData = JSON;
                                             [self saveCacheData];
                                         }
                                         
                                         if (self.delegate!=nil) {
                                             [self.delegate dataEntriesLoaded:self];
                                         }
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         self.isLoading = NO;
                                         if(self.delegate) {
                                             [self.delegate dataEntries:self LoadError:DBN_REQUEST_API_FAIL];
                                         }
                                     }];
        
    }else{
        
        [[DBNAPIClient sharedClient] postPath:self.apiName parameters:params needIdInfo:YES success:^(AFHTTPRequestOperation *operation, id JSON) {
            self.isLoading = NO;
#ifdef DEBUG
            NSLog(@"接口：（%@）:%@",self.apiName,JSON);
#endif
            
            if ([[JSON objectForKey:@"code"] intValue] == 1) {
                result(JSON);
                if (self.delegate!=nil) {
                    [self.delegate dataEntriesLoaded:self];
                }
                return ;
            }
            
            if ([[JSON objectForKey:@"code"] intValue] != 0) {
                NSLog(@"[%@]:%@",self.apiName,[JSON objectForKey:@"error"]);
                if(self.delegate) {
                    [self.delegate dataEntries:self LoadError:[JSON objectForKey:@"error"]];
                }
                return ;
            }
            
            if (result) {
                result(JSON);
            }
            
            if (cache) {
                self.cacheData = JSON;
                [self saveCacheData];
            }
            
            if (self.delegate!=nil) {
                [self.delegate dataEntriesLoaded:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
            self.isLoading = NO;
#ifdef DEBUG
            NSLog(@"error:（%@）:%@",self.apiName,error);
#endif
            if(self.delegate) {
                [self.delegate dataEntries:self LoadError:DBN_REQUEST_API_FAIL];
            }
        }];
        
    }
}

- (void)dealloc {
    [_fullCachePath release];
    [_cacheData release];
    [_cachePath release];
    [super dealloc];
}
@end
