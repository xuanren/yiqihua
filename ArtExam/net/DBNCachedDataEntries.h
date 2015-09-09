//
//  DBNCachedDataEntries.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/12/13.
//
//

#import "DBNDataEntries.h"

@interface DBNCachedDataEntries : DBNDataEntries

@property (nonatomic, retain) NSObject *cacheData;
@property (nonatomic, retain) NSString *cachePath;
@property (nonatomic, retain) NSString *fullCachePath;

- (id)initWithAPIName:(NSString *)apiName cachePath:(NSString*)name;
- (id)initWithAPIName:(NSString *)apiName andFullCachePath:(NSString*)path;
- (void)saveCacheData;

- (void)getCacheDataEntriesWithParameters:(NSMutableDictionary *)params andCacheData:(BOOL)cache andMethord:(NSString *)methord completion:(void (^)(id))result;

@end
