//
//  AEUserRelatedData.h
//  ArtExam
//
//  Created by dahai on 14-9-22.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEUserRelatedData : NSObject

@property (nonatomic, strong) NSString *articleNum;
@property (nonatomic, strong) NSString *avatarurl;
@property (nonatomic, strong) NSString *collegeNum;
@property (nonatomic, strong) NSString *followedNum;
@property (nonatomic, strong) NSString *followerNum;
@property (nonatomic, strong) NSString *questionNum;
@property (nonatomic) int userId;
@property (nonatomic) int roleId;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *studioNum;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *verfify;
@property (nonatomic, strong) NSDictionary *levelInfo;
@property (nonatomic, strong) NSString *imageNum;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
