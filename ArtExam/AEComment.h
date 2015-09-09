//
//  AEComment.h
//  ArtExam
//
//  Created by dkllc on 14-9-16.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AETopicUser.h"

@interface AEComment : NSObject

@property (nonatomic, strong) AETopicUser *user;
@property (nonatomic, strong) AETopicUser *origUser;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *origcommentDic;
@property (nonatomic) int origuid;
@property (nonatomic) int postid;
@property (nonatomic) long long subtime;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic) int commentId;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
