//
//  AETeacherInfo.h
//  ArtExam
//
//  Created by dahai on 14-9-14.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AETopicUser.h"

@interface AETeacherInfo : NSObject

@property (nonatomic, strong) AETopicUser *user;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
