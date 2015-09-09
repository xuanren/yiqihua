//
//  AEHomeFeedList.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNCachedDataEntries.h"

@interface AEHomeFeedList : DBNCachedDataEntries{
}

@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *feedArr;


- (void)getMostRecentHomeFeeds;
- (void)getPrevHomeFeeds;

@end
