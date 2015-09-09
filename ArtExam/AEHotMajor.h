//
//  AEHotMajor.h
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEHotMajor : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic) long long subtime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
