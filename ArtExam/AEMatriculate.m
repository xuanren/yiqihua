//
//  AEMatriculate.m
//  ArtExam
//
//  Created by Zhengen on 15-6-10.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEMatriculate.h"

@implementation AEMatriculate

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    self.title = att[@"title"];
    self.idStr = att[@"id"];
    return self;
}

@end
