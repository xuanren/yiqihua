//
//  AETeacherInfoList.h
//  ArtExam
//
//  Created by dahai on 14-9-14.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AETeacherInfo.h"

@interface AETeacherInfoList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *teacherArr;

- (void)getMostRecentTeachers;
- (void)getPrevTeachers;

@end
