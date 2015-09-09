//
//  AECircle.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AECircle : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *mydescription;
@property (nonatomic) int circieLd;


- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
