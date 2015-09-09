//
//  AEAdmissions.h
//  ArtExam
//
//  Created by Zhengen on 15-6-18.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEAdmissions : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *idStr;
- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
