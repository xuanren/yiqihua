//
//  DBNAPIClient.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/13/13.
//
//

#import "DBNAPIClient.h"
#import "DBNProperties.h"
#import "DBNUserDefaults.h"
#import "DBNUser.h"

@implementation DBNAPIClient

+ (DBNAPIClient *)sharedClient {
    static DBNAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [[NSURL alloc] initWithString:[[DBNProperties sharedDBNProperties] httpServiceAddress]];
        _sharedClient = [[DBNAPIClient alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSMutableDictionary *)parameters
     needIdInfo:(BOOL)needIdInfo
        success:(void (^)(AFHTTPRequestOperation *, id))success
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
{
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    [parameters setObject:@"ios" forKey:@"device"];
    [parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [parameters setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
    }

    if(needIdInfo){
        NSArray *keys = [parameters allKeys];
        if ([keys containsObject:@"sessionKey"]) {
        }else{
            if ([DBNUser sharedDBNUser].loggedIn && [DBNUser sharedDBNUser].sessionKey != nil) {
            }
        }
    }

    [super getPath:path parameters:parameters success:success failure:failure];
}

- (void)postPath:(NSString *)path
      parameters:(NSMutableDictionary *)parameters
      needIdInfo:(BOOL)needIdInfo
         success:(void (^)(AFHTTPRequestOperation *, id))success
         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    }
//    [parameters setObject:@"ios" forKey:@"device"];
//    [parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
//    if ([DBNUser sharedDBNUser].sessionKey) {
//        [parameters setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
//    }
    [super postPath:path parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation*)postPath2:(NSString *)path
                          parameters:(NSMutableDictionary *)parameters
                          needIdInfo:(BOOL)needIdInfo
                             success:(void (^)(AFHTTPRequestOperation *, id))success
                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    [parameters setObject:@"ios" forKey:@"device"];
    [parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [parameters setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
    }

    if(needIdInfo){
        NSArray *keys = [parameters allKeys];
        if ([keys containsObject:@"sessionKey"]) {
        }else{
        }
    }    NSMutableURLRequest *request = [super requestWithMethod:@"POST" path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    return operation;
}

- (AFHTTPRequestOperation*)postmultipartFormDataPath:(NSString *)path
                                          parameters:(NSMutableDictionary *)parameters
                                    constructingBody:(void (^)(id<AFMultipartFormData>))formDataBlock
                                          needIdInfo:(BOOL)needIdInfo
                                             success:(void (^)(AFHTTPRequestOperation *, id))success
                                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    [parameters setObject:@"ios" forKey:@"device"];
    [parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [parameters setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
    }

    if(needIdInfo){
        NSArray *keys = [parameters allKeys];
        if ([keys containsObject:@"sessionKey"]) {
        }else{
            if ([DBNUser sharedDBNUser].loggedIn && [DBNUser sharedDBNUser].sessionKey != nil) {
            }
        }
    }    NSMutableURLRequest *request = [super multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:formDataBlock];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    return operation;
}

- (void)cancelAllHTTPOperationsWithMethod:(NSString *)method pathWithoutQuery:(NSString *)path {
    NSString *URLStringToMatched = [[[self requestWithMethod:(method ?: @"GET") path:path parameters:nil] URL] absoluteString];
    
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        BOOL hasMatchingMethod = !method || [method isEqualToString:[[(AFHTTPRequestOperation *)operation request] HTTPMethod]];
        NSURL *currURL = [[(AFHTTPRequestOperation *)operation request] URL];
        NSString *urlStrWithoutQuery = [self getURLStringWithoutQuery:currURL];
        BOOL hasMatchingURL = [urlStrWithoutQuery isEqualToString:URLStringToMatched];
        
        if (hasMatchingMethod && hasMatchingURL) {
            [operation cancel];
        }
    }
}
                                         
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    [parameters setObject:@"ios" forKey:@"device"];
    [parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    return request;
}


// 将url的参数部分去掉
- (NSString*)getURLStringWithoutQuery:(NSURL*)orgURL {
    NSString *strippedString = [orgURL absoluteString];
    NSUInteger queryLength = [[orgURL query] length];
    strippedString = (queryLength ? [strippedString substringToIndex:[strippedString length] - (queryLength + 1)] : strippedString);
    return strippedString;
}

@end
