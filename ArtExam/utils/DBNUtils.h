//
//  DBNUtils.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 12/13/12.
//
//

#import <Foundation/Foundation.h>

@interface DBNUtils : NSObject

// create ASIHTTPRequest object with cache policy ASIAskServerIfModifiedCachePolicy
//+ (ASIHTTPRequest*)createCachedRequest:(NSString*)urlStr;

+ (NSString*)time:(long long)now since:(long long)since;
+ (NSString*)time1:(long long)now since1:(long long)since;
+ (NSString*)time:(long long)now;
+ (NSString*)time1:(long long)now;
+ (NSString*)time2:(long long)now;
+ (NSString*)time3:(long long)now;
+ (int)daysToToday:(long long)timestamp;

+ (NSString*)distance:(double)dis;
+ (NSString*) getDistanceWithCurrLatitude:(double) lat1 andCurrLongitude:(double)lng1 andDesLatitude:(double)lat2 andDeslongitude:(double)lng2;

+ (BOOL) isNumber:(NSString*)text;
+ (BOOL) isEmpty:(NSString*)text;
+ (BOOL)isValidCellPhone:(NSString*)text;

+ (UIImage *) resizeImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(UIColor *)getColor:(NSString *)hexColor;

+ (id)getObjectWithAttributs:(NSDictionary *)dic andKey:(NSString *)key;

@end
