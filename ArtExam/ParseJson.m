//
//  ParseJson.m
//  LightApp
//
//  Created by 陈月 on 14-8-18.
//  Copyright (c) 2014年 chenyue. All rights reserved.
//

#import "ParseJson.h"

@implementation ParseJson
+ (NSDictionary *)parseJsonToDictionary :(NSURL *)strUrl
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:strUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:2];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"XXXXX%@",responseData);
    if (responseData != nil)
    {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@->	%@",strUrl,responseDic);
        return responseDic;
    }
    return nil;
}
@end
