//
//  DBNUtils.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 12/13/12.
//
//

#define PI 3.1415926

#import "DBNUtils.h"

@implementation DBNUtils

//+ (ASIHTTPRequest*)createCachedRequest:(NSString*)urlStr {
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
//    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
//    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy];
//    [request setDownloadCache:[ASIDownloadCache sharedCache]];
//    return request;
//}

+ (NSString*)time:(long long)now since:(long long)since {
    long long timeDiff = (now - since);
    long long day = timeDiff / (1000*3600*24);
    long long month = day / 30;
    long long year = month / 12;
    if(year > 0) {
        return [NSString stringWithFormat:@"%lld年前",year];
    }
    if(month > 0) {
        return [NSString stringWithFormat:@"%lld月前",month];
    }
    if(day > 0) {
        return [NSString stringWithFormat:@"%lld天前",day];
    }
    long long hour = timeDiff / (1000*3600);
    if(hour > 0) {
        return [NSString stringWithFormat:@"%lld小时前",hour];
    }
    long long mins = timeDiff / (1000*60);
    return [NSString stringWithFormat:@"%lld分钟前",mins];
}

+ (NSString*)time1:(long long)now since1:(long long)since{
    long long timeDiff = (now - since);
    long long day = (timeDiff / (1000*3600*24));
    if (day >= 7) {
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:since/1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString * time=[dateFormatter stringFromDate:confromTimesp];
        [dateFormatter release];
        return time;
    }
    
    if(day > 0) {
        return [NSString stringWithFormat:@"%lld天前",day];
    }
    long long hour = (int)timeDiff / (1000*3600);
    if(hour > 0) {
        return [NSString stringWithFormat:@"%lld小时前",hour];
    }
    long long mins = timeDiff / (1000*60);
    if(mins == 0) return @"刚刚";
    return [NSString stringWithFormat:@"%lld分钟前",mins];
}

+ (NSString*)time:(long long)now{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:now/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString * time=[dateFormatter stringFromDate:confromTimesp];
    [dateFormatter release];
    return time;
}

+ (NSString*)time1:(long long)now{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:now/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString * time=[dateFormatter stringFromDate:confromTimesp];
    [dateFormatter release];
    return time;
}

+ (NSString*)time2:(long long)now{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:now/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString * time=[dateFormatter stringFromDate:confromTimesp];
    [dateFormatter release];
    return time;
}

+ (NSString*)time3:(long long)now{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:now/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH点"];
    NSString * time=[dateFormatter stringFromDate:confromTimesp];
    [dateFormatter release];
    return time;
}


+ (int)daysToToday:(long long)timestamp {
    NSDate *nsdate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDate *now = [NSDate date];
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components: NSDayCalendarUnit
                                                      fromDate: nsdate
                                                        toDate: now
                                                       options: 0];
    
    return [components day];
}

+ (BOOL) isNumber:(NSString*)text
{
    if (text == nil) {
        return NO;
    }
    
    NSString * regex        = @"^[0-9]+(.[0-9]+)?$*";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:text];
}

+ (BOOL) isEmpty:(NSString *)text
{
    if(text == nil) {
        return YES;
    }
    
    NSString *trimed = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([trimed isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isValidCellPhone:(NSString *)text {
    NSString *phoneRegex =@"^[1][\\d]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:text];
}

+ (UIImage *) resizeImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString*)distance:(double)dis{
    if (dis <= 0.0) {
        return nil;
    }
    if (dis<1000) {
        return [NSString stringWithFormat:@"%.0f m",dis];
    }else{
        return [NSString stringWithFormat:@"%.1f km",dis/1000];
    }
}

+ (NSString*) getDistanceWithCurrLatitude:(double) lat1 andCurrLongitude:(double)lng1 andDesLatitude:(double)lat2 andDeslongitude:(double)lng2{
    if (lat2 <=0.0 && lng2<=0.0) {
        return nil;
    }
    double er = 6378137; // 6378700.0f;
	double radlat1 = PI*lat1/180.0f;
	double radlat2 = PI*lat2/180.0f;
    
	//now long.
    
	double radlong1 = PI*lng1/180.0f;
    
	double radlong2 = PI*lng2/180.0f;
    
	if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    
	if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    
	if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    
	if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    
	if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    
	if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    
	//spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    
	//zero ag is up so reverse lat
    
	double x1 = er * cos(radlong1) * sin(radlat1);
    
	double y1 = er * sin(radlong1) * sin(radlat1);
    
	double z1 = er * cos(radlat1);
    
	double x2 = er * cos(radlong2) * sin(radlat2);
    
	double y2 = er * sin(radlong2) * sin(radlat2);
    
	double z2 = er * cos(radlat2);
    
	double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    
	//side, side, side, law of cosines and arccos
	double theta = acos((er*er+er*er-d*d)/(2*er*er));
	double dist  = theta*er;
    if (dist<1000) {
        return [NSString stringWithFormat:@"%.0f m",dist];
    }else{
        return [NSString stringWithFormat:@"%.1f km",dist/1000];
    }

}

+(UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

+ (id)getObjectWithAttributs:(NSDictionary *)dic andKey:(NSString *)key{
    NSArray *keys = [dic allKeys];
    
    if ([keys containsObject:key]) {
        if ([dic objectForKey:key] == [NSNull null] || [dic objectForKey:key] == nil) return nil;
        return [dic objectForKey:key];
    }else return nil;
}


@end
