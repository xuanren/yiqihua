//
//  AEQuestionBankList.h
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AEQuestionBankList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *questionBankAry;
@property (strong, nonatomic) NSString *colleageID;

- (void)getMostRecentQuestionList;
- (void)getPrevQuestionList;

@end
