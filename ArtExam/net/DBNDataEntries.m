//
//  DBNDataEntries.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/16/13.
//
//

#import "DBNDataEntries.h"
#import "DBNAPIClient.h"
#import "DBNStatusView.h"
#import "DBNStrings.h"

@implementation DBNDataEntries

@synthesize entryCount;
@synthesize noMoreEntry;
@synthesize apiName;
@synthesize delegate;
@synthesize isLoading = _isLoading;

- (id)initWithAPIName:(NSString*)api {
    self = [super init];
    if(self) {
        noMoreEntry = NO;
        entryCount = 20;
        self.apiName = api;
        _mark = 0;
        _page = 1;
    }
    return self;
}

- (void)clearDelegateAndCancelRequests {
    self.delegate = nil;
    [[DBNAPIClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" pathWithoutQuery:self.apiName];
}


- (void)getDataEntriesWithParameters:(NSMutableDictionary *)params andMethord:(NSString *)methord completion:(void (^)(id))result{
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
            if ([JSON objectForKey:@"rows"]) {
                if (result) {
                    result(JSON);
                }
                if (self.delegate!=nil) {
                    [self.delegate dataEntriesLoaded:self];
                }
                return ;
            }
            
            
            if ([[JSON objectForKey:@"code"] intValue] == 1) {
                if (result) {
                    result(JSON);
                }
            }
            
            if ([[JSON objectForKey:@"code"] intValue] != 1) {
                NSLog(@"[%@]:%@",self.apiName,[JSON objectForKey:@"error"]);
                if(self.delegate) {
                    [self.delegate dataEntries:self LoadError:[JSON objectForKey:@"error"]];
                }
                return ;
            }
            if (self.delegate!=nil) {
                [self.delegate dataEntriesLoaded:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
            self.isLoading = NO;
            if(self.delegate) {
                [self.delegate dataEntries:self LoadError:DBN_REQUEST_API_FAIL];
            }
        }];
        
    }
}

- (void)dealloc {
    [apiName release];
    [super dealloc];
}

@end
