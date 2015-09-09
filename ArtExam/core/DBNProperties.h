//
//  DBNProperties.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBNProperties : NSObject {
@private
    NSString *_documentPath;
    NSString *_cachePath;
    NSString *_hairCachePath;   // hairstyle images and jsons cache path in user device
    NSString *_dbnInfoCachePath;// path for dbn cache: DBNiPhoneHairAppConfig.json, hairList.json, hairCategory.json, etc.
    
    NSDictionary *_configData;   // data read from DBNiPhoneHairAppConfig.json
}

+ (DBNProperties *)sharedDBNProperties; 

- (NSString*)documentPath;
- (NSString*)cachePath;
- (NSString*)httpServiceAddress;    // API server address
- (NSString*)dbnInfoCachePath;
- (NSString*)BarberPath;

- (NSString*)getAppStoreId; // app id in app store

- (int)maxImageDimension;
@end
