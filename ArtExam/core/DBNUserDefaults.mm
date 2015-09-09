//
//  DBNUserDefaults.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBNUserDefaults.h"
//#import "CWLSynthesizeSingleton.h"
#import "DBNConsts.h"

@implementation DBNUserDefaults
//CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(DBNUserDefaults);

+(DBNUserDefaults *)sharedDBNUserDefaults {
    static dispatch_once_t pred;
    static DBNUserDefaults *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[DBNUserDefaults alloc] init];
    });
    return shared;
}

@synthesize userDefaults = _userDefaults;
@synthesize appVersion = _appVersion;
@synthesize isAppFirstStarted = _isAppFirstStarted;
@synthesize isAppJustUpdated = _isAppJustUpdated;
@synthesize appStartCount = _appStartCount;

- (id)init {
    self = [super init];
    if(self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.appVersion = [self.userDefaults stringForKey:kAppVersion];
        self.appStartCount = [self.userDefaults integerForKey:kStartCount];
        self.appStartCount += 1;
        [self.userDefaults setInteger:self.appStartCount forKey:kStartCount];
        
        // check current app version 
        NSString *currAppVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
        if(!self.appVersion) {
            self.appVersion = currAppVersion;
            self.isAppFirstStarted = YES;
            [self.userDefaults setObject:self.appVersion forKey:kAppVersion];
        }
        else if([self.appVersion compare:currAppVersion options:NSNumericSearch] == NSOrderedAscending) {
            self.appVersion = currAppVersion;
            self.isAppJustUpdated = YES;
            [self.userDefaults setObject:self.appVersion forKey:kAppVersion];
        }
        
        [self.userDefaults synchronize];
    }
    return self;
}

@end
