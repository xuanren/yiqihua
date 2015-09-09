//
//  AEAdvertisement.h
//  ArtExam
//
//  Created by dahai on 14-10-8.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    Gallery_Type = 1,
//    Information_Type = 2,
//    CollegeHomePage_Type = 3,
//    StudioHomePage_Type = 4,
//    Topic_Type = 5
//} HomeFeedType;

@interface AEAdvertisement : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *descStr;
@property (nonatomic) int albumid;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic) long long subtime;


- (instancetype)initWithAttributes:(NSDictionary *)att;
@end
