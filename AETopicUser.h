//
//  AETopicUser.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AETopicUser : NSObject

@property (nonatomic, strong) NSString *academyName;
@property (nonatomic, strong) NSString *teacherDesc;
@property (nonatomic, strong) NSString *mydescription;
@property (nonatomic) int userId;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *teacherPosition;
@property (nonatomic) UserRole userRole;
@property (nonatomic, strong) NSString *studioName;
@property (nonatomic) BOOL isVerified;
@property (nonatomic, strong) NSString *userName;


- (instancetype)initWithAttributes:(NSDictionary *)att;


@end
