//
//  AEStudio.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEStudio : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *mydescription;
@property (nonatomic) int studioId;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int locationId;
@property (nonatomic) int scale;
@property (nonatomic) int popular;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *locationName;
@property (nonatomic) long long popularity;
@property (nonatomic) BOOL isFavorite;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
