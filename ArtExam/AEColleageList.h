//
//  AEColleageList.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AEColleage.h"

@interface AEColleageList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *schoolList;
@property (nonatomic, strong) AEColleage *collegeDetail;
@property (nonatomic, strong) NSString *collegeId;
@property (nonatomic) int locationId;

- (instancetype)initWithAPIName:(NSString *)apiName andDetailId:(NSString *)collegeId;
- (instancetype)initWithAPIName:(NSString *)apiName andUserId:(int)userId;
- (instancetype)initWithAPIName:(NSString *)apiName andLocationId:(int)locationId;

- (void)getMostRecentSchools;
- (void)getPrevSchools;

- (void)getSchoolDetail;

- (void)getSearchCollectListsForKey:(NSString *)key;

- (void)getMostRecentMyCollegeList;
- (void)getPrevMyCollegeList;

- (void)getMostCollectCollegeList;
@end
