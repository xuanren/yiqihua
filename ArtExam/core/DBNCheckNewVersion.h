//
//  DBNCheckNewVersion.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DBNUnUpdateVersion = 0,
    DBNUpdateNewVersion= 1,
    DBNMustUpdateNewVersion=2
} UpdateVersion;

@protocol DBNCheckNewVersionDelegate <NSObject>

@optional 
- (void)userWillUpdateNewVersion;

@optional 
- (void)userSkipNewVersion;

@optional 
- (void)appIsUpToDate;

@optional
- (void)checkUpdateServerError;

@end

@interface DBNCheckNewVersion : NSObject <UIAlertViewDelegate>

@property (nonatomic, assign) id<DBNCheckNewVersionDelegate> delegate;
@property (nonatomic, strong) NSDictionary *versionJson;
@property (nonatomic) UpdateVersion *updateVersion;

- (void)checkAppUpdate;

@end
