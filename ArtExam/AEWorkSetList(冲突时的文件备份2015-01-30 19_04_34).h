//
//  AEWorkSetList.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNCachedDataEntries.h"


@interface AEWorkSetList : DBNCachedDataEntries


@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *workSetArr;//精华

@property (nonatomic, strong) NSMutableArray *workSetArrRecommand;//推荐

@property (nonatomic, assign) TopicType myType;

- (void)getMostRecentWorkSets;
- (void)getPrevWorkSets;


@end
