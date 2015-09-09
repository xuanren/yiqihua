//
//  DBNDataEntries.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/16/13.
//
//

#import <Foundation/Foundation.h>

@class DBNDataEntries;
@protocol DBNDataEntriesDelegate <NSObject>

- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries;
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error;

@end

@interface DBNDataEntries : NSObject {
    int _mark;
    int _page;
}

@property (nonatomic) int entryCount;   // number of entries retrieved every request
@property (nonatomic) BOOL noMoreEntry;   // indicator whether there is no more entry
@property (nonatomic, retain) NSString *apiName;
@property (nonatomic) BOOL isLoading;
@property (nonatomic, assign) id<DBNDataEntriesDelegate> delegate;

- (id)initWithAPIName:(NSString*)apiName;

- (void)clearDelegateAndCancelRequests;

- (void)getDataEntriesWithParameters:(NSMutableDictionary *)params andMethord:(NSString *)methord completion:(void (^)(id))result;

@end
