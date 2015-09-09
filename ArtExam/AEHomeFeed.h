//
//  AEHomeFeed.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Gallery_Type = 1,
    Information_Type = 2,
    CollegeHomePage_Type = 3,
    StudioHomePage_Type = 4,
    Topic_Type = 5,
    WebView_Type = 6
} HomeFeedType;

@interface AEHomeFeed : NSObject

@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *mydescription;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic) long long subTime;
//@property (nonatomic) int typeId;
//@property (nonatomic) HomeFeedType feedType;

@property (nonatomic, strong) NSString *feedType;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *viewNum;  // 热度（查看次数）

- (id)initWithAttributes:(NSDictionary *)att;

@end
