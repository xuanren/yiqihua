//
//  ParseJson.h
//  LightApp
//
//  Created by 陈月 on 14-8-18.
//  Copyright (c) 2014年 chenyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseJson : NSObject
+ (NSDictionary *)parseJsonToDictionary :(NSURL *)strUrl;
@end
