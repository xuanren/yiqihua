//
//  AEWorkSet.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEWorkSet : NSObject

@property (nonatomic) int workSetId;
@property (nonatomic, copy) NSString *mydescription;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, strong) NSMutableArray *picArr;


- (id)initWithAttributes:(NSDictionary *)att;

@end
