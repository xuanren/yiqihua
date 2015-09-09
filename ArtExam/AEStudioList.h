//
//  AEStudioList.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AEStudioList : DBNDataEntries

@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *studioArr;
@property (nonatomic) int locationId;

- (void)getMostRecentStudios;
- (void)getPrevStudions;


- (void)getMyStudiosWithUserId:(int)uId;
- (void)getMyPrevStudions:(int)uId;


@end
