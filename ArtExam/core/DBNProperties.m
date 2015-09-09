//
//  DBNProperties.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBNProperties.h"
//#import "CWLSynthesizeSingleton.h"
#import "SBJson.h"
#import "DBNConsts.h"

@implementation DBNProperties

//CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(DBNProperties);

+(DBNProperties *)sharedDBNProperties {
    static dispatch_once_t pred;
    static DBNProperties *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[DBNProperties alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if(self) {
/*        NSString *jsonPath = [[self dbnInfoCachePath] stringByAppendingPathComponent:@"DBNiPhoneHairAppConfig.json"];
        NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
        if(jsonStr) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            _configData = [parser objectWithString:jsonStr];
           // _configData = [jsonStr JSONValue];
        }
        else {
            jsonPath = [[NSBundle mainBundle] pathForResource:@"DBNiPhoneHairAppConfig" ofType:@"json"];
            if(jsonPath) {
                NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
                if(jsonStr) {
                   // _configData =[jsonStr JSONValue];
                    SBJsonParser *parser = [[SBJsonParser alloc]init];
                    _configData = [parser objectWithString:jsonStr];
                }
            }
        }
*/    }
    return self;
}

- (NSString*)documentPath {
    if(!_documentPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentPath = [paths objectAtIndex:0];
    }
    return _documentPath;
}

- (NSString*)BarberPath {
    NSString *path = [[self documentPath] stringByAppendingPathComponent:@"barbers"];;
    return path;
}

- (NSString*)cachePath {
    if(!_cachePath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _cachePath = [paths objectAtIndex:0];
    }
    return _cachePath;
}

- (NSString*)httpServiceAddress {
#ifdef DEBUG
    return ROOTURL;
    return @"http://www.yiqihua.cn/artbox/";
    return @"http://ae.bdqrc.cn/";
    return @"http://aed.bdqrc.cn/";
#endif
    return @"http://salonapi.dabanniu.com/";
}

- (NSString*)hairstyleCachePath {
    if(!_hairCachePath) {
        _hairCachePath = [[self cachePath] stringByAppendingPathComponent:@"hairstyleCache"];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        if(![fileManager fileExistsAtPath:_hairCachePath]) {
            [fileManager createDirectoryAtPath:_hairCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _hairCachePath;
}

- (NSString*)dbnInfoCachePath {
    if(!_dbnInfoCachePath) {
        _dbnInfoCachePath = [[self cachePath] stringByAppendingPathComponent:@"dbnInfoCache"];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        if(![fileManager fileExistsAtPath:_dbnInfoCachePath]) {
            [fileManager createDirectoryAtPath:_dbnInfoCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _dbnInfoCachePath;
}

- (int)maxImageDimension {
    return 1024;
}

- (NSString*)getAppStoreId {
    if(_configData && [_configData objectForKey:@"appStoreId"]) {
        return [_configData objectForKey:@"appStoreId"];
    }
    return @"680516889";
}

@end
