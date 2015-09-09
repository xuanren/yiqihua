//
//  AETopicList.h
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNCachedDataEntries.h"

@interface AETopicList : DBNCachedDataEntries
@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *topicArr;
@property (nonatomic) TopicType type;

@property (nonatomic) BOOL needLoadCache;

- (void)getMostRecentTopics;
- (void)getPrevTopics;

- (void)getMyMostRecentTopics:(int)uId;
- (void)getMyPrevTopics:(int)uId;

@end
