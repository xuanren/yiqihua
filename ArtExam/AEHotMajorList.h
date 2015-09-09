//
//  AEHotMajorList.h
//  ArtExam
//
//  Created by dahai on 14-9-20.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AEHotMajorList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *hotMajorAry;

- (void)getMostRecentHotMajorList;
- (void)getPrevHotMajorList;

@end
