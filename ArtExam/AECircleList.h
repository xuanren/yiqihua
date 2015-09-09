//
//  AECircleList.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AECircleList : DBNDataEntries

@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *circleArr;


- (void)getAllCircles;
@end
