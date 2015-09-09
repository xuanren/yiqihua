//
//  AEAdmissions.m
//  ArtExam
//
//  Created by Zhengen on 15-6-18.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEAdmissions.h"

@implementation AEAdmissions

- (instancetype)initWithAttributes:(NSDictionary *)att{
    
    self = [super init];
    self.title = att[@"title"];
    self.idStr = att[@"id"];
    return self;
}

@end
