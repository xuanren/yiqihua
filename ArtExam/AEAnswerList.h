//
//  AEAnswerList.h
//  ArtExam
//
//  Created by dkllc on 14-9-14.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AEQuestion.h"

@interface AEAnswerList : DBNDataEntries

@property (nonatomic) long long timeStamp;  // the time stamp on server when getting post list
@property (nonatomic, strong) NSMutableArray *answerArr;
@property (nonatomic, strong) AEQuestion *question;
@property (nonatomic) int questionId;

- (instancetype)initWithAPIName:(NSString *)apiName andQUestionId:(int)qId;

- (void)getMostRecentAnswers;
- (void)getPrevAnswers;


@end
