//
//  AECommentList.h
//  ArtExam
//
//  Created by dkllc on 14-9-16.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AETopic.h"

@interface AECommentList : DBNDataEntries

@property (nonatomic, strong) AETopic *topic;

@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic) int postId;

- (instancetype)initWithAPIName:(NSString *)apiName andPostId:(int)pId;

- (void)getMostRecentComments;
- (void)getPrevComments;


@end
