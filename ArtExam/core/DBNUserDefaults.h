//
//  DBNUserDefaults.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBNUserDefaults : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic) BOOL isAppFirstStarted;
@property (nonatomic) BOOL isAppJustUpdated;
@property (nonatomic) int appStartCount;    // accumulate count of user starting the app

+ (DBNUserDefaults*)sharedDBNUserDefaults;

@end
