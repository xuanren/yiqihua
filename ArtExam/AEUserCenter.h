//
//  AEUserCenter.h
//  ArtExam
//
//  Created by dahai on 14-9-22.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AEUserRelatedData.h"

@interface AEUserCenter : DBNDataEntries

@property (nonatomic, strong) AEUserRelatedData *userRelate;

- (instancetype)initWithAPIName:(NSString *)apiName andUserId:(int)userId;
- (void)getUserInfo;

@end
