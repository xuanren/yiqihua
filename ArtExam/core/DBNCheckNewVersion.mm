//
//  DBNCheckNewVersion.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBNCheckNewVersion.h"
#import "SBJson.h"
#import "DBNUserDefaults.h"
#import "DBNAPIList.h"
#import "DBNAPIClient.h"
@interface DBNCheckNewVersion (PrivateMethods)

- (void)displayAppUpdate:(NSDictionary*)jsonObj;

@end

@implementation DBNCheckNewVersion

@synthesize delegate;
@synthesize versionJson;
@synthesize updateVersion;

- (id)init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void)checkAppUpdate {

//    [[DBNAPIClient sharedClient] getPath:[DBNAPIList checkVersionJsonAddress] parameters:nil needIdInfo:NO success:^(AFHTTPRequestOperation * operation, id JSON) {
//        if ([[JSON objectForKey:@"error"] intValue]!=0) {
//            if(delegate && [delegate respondsToSelector:@selector(checkUpdateServerError)]) {
//                [delegate checkUpdateServerError];
//            }
//            return ;
//        }
//        
//        self.versionJson = JSON;
//        switch ([[self.versionJson objectForKey:@"type"] intValue]) {
//            case 0:
//            {
//                if(delegate && [delegate respondsToSelector:@selector(appIsUpToDate)]) {
//                    [delegate appIsUpToDate];
//                }
//            }
//                break;
//            case 1:
//            {
//                [self displayAppUpdate:self.versionJson];
//            }
//                break;
//            case 2:
//            {
//                [self displayMustAppUpdate:self.versionJson];
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
//    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
//        if(delegate && [delegate respondsToSelector:@selector(checkUpdateServerError)]) {
//            [delegate checkUpdateServerError];
//        }
//    }];
}

- (void)displayAppUpdate:(NSDictionary*)jsonObj {
    NSString *appVersion = [jsonObj objectForKey:@"version"];
    NSString *whatsNew = [jsonObj objectForKey:@"content"];
    
    NSString *title = @"发现新版本";
    title = [title stringByAppendingString:appVersion];
    if(!whatsNew) {
        whatsNew = @"检查到新版本。您要前往App Store下载最新版本吗？";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:whatsNew 
                                                       delegate:self 
                                              cancelButtonTitle:@"跳过" 
                                              otherButtonTitles:@"升级", nil];
    alertView.tag = 0;
    [alertView show];
}

- (void)displayMustAppUpdate:(NSDictionary*)jsonObj {
    NSString *whatsNew = [jsonObj objectForKey:@"content"];
    if (whatsNew == nil || [whatsNew isEqualToString:@""]) {
        whatsNew = @"打扮妞已不支持您当前的版本,请前往App Store下载最新版本";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:whatsNew
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"升级", nil];
    alertView.tag = 1;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if(buttonIndex == 0) {
            if(delegate && [delegate respondsToSelector:@selector(userSkipNewVersion)]) {
                [delegate userSkipNewVersion];
            }
        }
        else if(buttonIndex == 1) {
            if(delegate && [delegate respondsToSelector:@selector(userWillUpdateNewVersion)]) {
                [delegate userWillUpdateNewVersion];
            }
            NSString *appStoreUrl = [versionJson objectForKey:@"appStoreUrl"];
            if(!appStoreUrl) appStoreUrl = @"itms-apps://itunes.com/apps/";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
        }
        return;
    }
    if (alertView.tag == 1) {
        if(delegate && [delegate respondsToSelector:@selector(userWillUpdateNewVersion)]) {
            [delegate userWillUpdateNewVersion];
        }
        NSString *appStoreUrl = [versionJson objectForKey:@"appStoreUrl"];
        if(!appStoreUrl) appStoreUrl = @"itms-apps://itunes.com/apps/";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
    }
}

@end
