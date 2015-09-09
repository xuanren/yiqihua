//
//  DBNAPIClient.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/13/13.
//
//

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@interface DBNAPIClient : AFHTTPClient

+ (DBNAPIClient *)sharedClient;

- (void)getPath:(NSString *)path
     parameters:(NSMutableDictionary *)parameters
     needIdInfo:(BOOL)needIdInfo
        success:(void (^)(AFHTTPRequestOperation *, id))success
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

- (void)postPath:(NSString *)path
      parameters:(NSMutableDictionary *)parameters
      needIdInfo:(BOOL)needIdInfo
         success:(void (^)(AFHTTPRequestOperation *, id))success
         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

// this method return an AFHTTPRequestOperation object
- (AFHTTPRequestOperation*)postPath2:(NSString *)path
                          parameters:(NSMutableDictionary *)parameters
                          needIdInfo:(BOOL)needIdInfo
                             success:(void (^)(AFHTTPRequestOperation *, id))success
                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

- (AFHTTPRequestOperation*)postmultipartFormDataPath:(NSString *)path
                                          parameters:(NSMutableDictionary *)parameters
                                    constructingBody:(void (^)(id<AFMultipartFormData> ))formDataBlock
                                          needIdInfo:(BOOL)needIdInfo
                                             success:(void (^)(AFHTTPRequestOperation *, id))success
                                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
        

- (void)cancelAllHTTPOperationsWithMethod:(NSString *)method pathWithoutQuery:(NSString *)path;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path;

@end